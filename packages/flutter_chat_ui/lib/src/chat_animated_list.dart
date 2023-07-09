import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class ChatAnimatedList extends StatefulWidget {
  const ChatAnimatedList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.insertAnimationBuilder,
    required this.removeAnimationBuilder,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.removeAnimationDuration = const Duration(milliseconds: 250),
    required this.author,
  });

  final List<Message> items;
  final Widget Function(BuildContext, Message) itemBuilder;
  final Widget Function(
    BuildContext,
    Animation<double>,
    Message,
    Widget,
  ) insertAnimationBuilder;
  final Widget Function(
    BuildContext,
    Animation<double>,
    Message,
    Widget,
  ) removeAnimationBuilder;
  final Duration insertAnimationDuration;
  final Duration removeAnimationDuration;
  final String author;

  @override
  ChatAnimatedListState createState() => ChatAnimatedListState();
}

class ChatAnimatedListState extends State<ChatAnimatedList> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  late List<Message> _oldList;
  final _scrollController = ScrollController();
  final lastKey = GlobalKey();
  bool _userHasScrolled = false;
  String _lastInsertedMessageId = '';

  @override
  void initState() {
    super.initState();
    _oldList = List.from(widget.items);
  }

  @override
  void didUpdateWidget(ChatAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newList = widget.items;

    final updates = diffutil
        .calculateDiff<Message>(
          MessageListDiff(_oldList, newList),
        )
        .getUpdatesWithData();
    // temp copy of old list to start the animations on the right positions
    final tempList = List<Message?>.from(_oldList);
    for (final update in updates) {
      _onDiffUpdate(update, tempList);
    }
    _oldList = List.from(newList);
  }

  void _onInserted(
    final int position,
    final Message data,
    final List<Message?> tempList,
  ) {
    if (widget.author == data.senderId ||
        (_userHasScrolled == true &&
            _scrollController.offset >=
                _scrollController.position.maxScrollExtent)) {
      _userHasScrolled = false;
    }

    _listKey.currentState!.insertItem(
      position,
      duration: _scrollController.position.maxScrollExtent == 0
          ? widget.insertAnimationDuration
          : Duration.zero,
    );
    tempList.insert(position, data);
    _lastInsertedMessageId = data.id;

    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (_scrollController.position.maxScrollExtent == 0) {
          _initialScrollToEnd();
        } else {
          _scrollToEnd(data);
        }
      },
    );
  }

  void _initialScrollToEnd() async {
    await Future.delayed(widget.insertAnimationDuration);
    if (_scrollController.hasClients &&
        _scrollController.offset < _scrollController.position.maxScrollExtent) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linearToEaseOut,
      );
    }
  }

  void _scrollToEnd(Message data) async {
    if (widget.author == data.senderId || !_userHasScrolled) {
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent.ceilToDouble(),
          duration: const Duration(milliseconds: 250),
          curve: Curves.linearToEaseOut,
        );
        if (_scrollController.hasClients &&
            _scrollController.offset <
                _scrollController.position.maxScrollExtent &&
            (widget.author == data.senderId || !_userHasScrolled) &&
            data.id == _lastInsertedMessageId) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      }
    }
  }

  void _onRemoved(
    final int position,
    final Message data,
    final List<Message?> tempList,
  ) {
    final oldItem = tempList[position]!;
    _listKey.currentState!.removeItem(
      position,
      (context, animation) => widget.removeAnimationBuilder(
        context,
        animation,
        oldItem,
        widget.itemBuilder(context, oldItem),
      ),
      duration: widget.removeAnimationDuration,
    );
    tempList.removeAt(position);
  }

  void _onChanged(int position) {
    _listKey.currentState!.removeItem(
      position,
      (context, animation) => const SizedBox.shrink(),
      duration: Duration.zero,
    );
    _listKey.currentState!.insertItem(
      position,
      duration: Duration.zero,
    );
  }

  void _onDiffUpdate(
    diffutil.DataDiffUpdate<Message> update,
    List<Message?> tempList,
  ) {
    update.when<void>(
      insert: (pos, data) => _onInserted(pos, data, tempList),
      remove: (pos, data) => _onRemoved(pos, data, tempList),
      change: (pos, oldData, newData) => _onChanged(pos),
      move: (_, __, ___) => throw UnimplementedError('unused'),
    );
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          // When user scrolls up, save it to `_userHasScrolled`
          if (notification.direction == ScrollDirection.forward) {
            _userHasScrolled = true;
          } else {
            // When user overscolls to the bottom or stays idle at the bottom, set `_userHasScrolled` to false
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              _userHasScrolled = false;
            }
          }

          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAnimatedList(
              key: _listKey,
              initialItemCount: widget.items.length,
              itemBuilder: (
                BuildContext context,
                int index,
                Animation<double> animation,
              ) =>
                  widget.insertAnimationBuilder(
                context,
                animation,
                widget.items[index],
                widget.itemBuilder(
                  context,
                  widget.items[index],
                ),
              ),
            ),
          ],
        ),
      );
}

class MessageListDiff extends diffutil.ListDiffDelegate<Message> {
  MessageListDiff(super.oldList, super.newList);

  @override
  bool areContentsTheSame(int oldItemPosition, int newItemPosition) =>
      equalityChecker(oldList[oldItemPosition], newList[newItemPosition]);

  @override
  bool areItemsTheSame(int oldItemPosition, int newItemPosition) =>
      oldList[oldItemPosition].id == newList[newItemPosition].id;
}
