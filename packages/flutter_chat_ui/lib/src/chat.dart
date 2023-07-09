import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';
import 'package:provider/provider.dart';
import './chat_animated_list.dart';

class Chat extends StatefulWidget {
  final List<Message> messages;
  final ChatTheme? theme;

  const Chat({
    super.key,
    required this.messages,
    this.theme,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  late ChatTheme _theme;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(_updateTheme);
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.theme != widget.theme) {
      _theme = _theme.merge(widget.theme);
    }
  }

  void _updateTheme() {
    _theme =
        ChatTheme.defaultTheme(PlatformDispatcher.instance.platformBrightness)
            .merge(widget.theme);
  }

  @override
  Widget build(BuildContext context) => Provider.value(
        value: _theme,
        child: ChatWidget(
          messages: widget.messages,
        ),
      );
}

class ChatWidget extends StatelessWidget {
  final List<Message> messages;

  const ChatWidget({
    super.key,
    required this.messages,
  });

  // Align(
  //         alignment: item.senderId == 'sender2'
  //             ? AlignmentDirectional.centerEnd
  //             : AlignmentDirectional.centerStart,

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.select((ChatTheme theme) => theme.backgroundColor);

    return Container(
      color: backgroundColor,
      child: ChatAnimatedList(
        items: messages,
        itemBuilder: (_, item) => FlyerChatTextMessage(
          key: ValueKey(item.id),
          message: item as TextMessage,
          isSentByMe: item.senderId == 'sender2',
        ),
        insertAnimationBuilder: (context, animation, item, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.linearToEaseOut,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SizeTransition(
              sizeFactor: curvedAnimation,
              child: ScaleTransition(
                scale: curvedAnimation,
                alignment: item.senderId == 'sender2'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: child,
              ),
            ),
          );
        },
        removeAnimationBuilder: (context, animation, item, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SizeTransition(
              sizeFactor: curvedAnimation,
              child: ScaleTransition(
                scale: curvedAnimation,
                alignment: item.senderId == 'sender2'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: child,
              ),
            ),
          );
        },
        author: 'sender2',
      ),
    );
  }
}
