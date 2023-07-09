import 'dart:math';

import 'package:flutter/material.dart' hide AnimatedList;
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

void main() {
  runApp(const FlyerChat());
}

class FlyerChat extends StatelessWidget {
  const FlyerChat({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const FlyerChatHomePage(),
      );
}

class FlyerChatHomePage extends StatefulWidget {
  const FlyerChatHomePage({super.key});

  @override
  State<FlyerChatHomePage> createState() => _FlyerChatHomePageState();
}

class _FlyerChatHomePageState extends State<FlyerChatHomePage> {
  // final _items = generateTextMessages(30);
  final List<Message> _items = [];
  // final List<Message> _items = [
  //   TextMessage(
  //     id: '1',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368000000),
  //     type: 'text',
  //     text: 'Hey Jane, how are you?',
  //   ),
  //   TextMessage(
  //     id: '2',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368001000),
  //     type: 'text',
  //     text: "I'm doing great John, thanks for asking! How about you?",
  //   ),
  //   TextMessage(
  //     id: '3',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368002000),
  //     type: 'text',
  //     text: "I'm doing well too, thank you.",
  //   ),
  //   TextMessage(
  //     id: '4',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368003000),
  //     type: 'text',
  //     text: 'I just remembered about our high school reunion.',
  //   ),
  //   TextMessage(
  //     id: '5',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368004000),
  //     type: 'text',
  //     text: 'Oh really? When is it?',
  //   ),
  //   TextMessage(
  //     id: '6',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368005000),
  //     type: 'text',
  //     text: 'Next month, on the 15th.',
  //   ),
  //   TextMessage(
  //     id: '7',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368006000),
  //     type: 'text',
  //     text: 'I had completely forgotten about it. Thanks for reminding me!',
  //   ),
  //   TextMessage(
  //     id: '8',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368007000),
  //     type: 'text',
  //     text: 'No problem at all!',
  //   ),
  //   TextMessage(
  //     id: '9',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368008000),
  //     type: 'text',
  //     text:
  //         "I'm actually excited about it. It's been so long since we all met.",
  //   ),
  //   TextMessage(
  //     id: '10',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368009000),
  //     type: 'text',
  //     text: "Yeah, it's going to be great to see everyone again.",
  //   ),
  //   TextMessage(
  //     id: '11',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368010000),
  //     type: 'text',
  //     text: 'Do you remember any details about the event?',
  //   ),
  //   TextMessage(
  //     id: '12',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368011000),
  //     type: 'text',
  //     text: "I think it's going to be held at our old high school.",
  //   ),
  //   TextMessage(
  //     id: '13',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368012000),
  //     type: 'text',
  //     text: 'That sounds nostalgic. I wonder how much the place has changed.',
  //   ),
  //   TextMessage(
  //     id: '14',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368013000),
  //     type: 'text',
  //     text:
  //         "I heard they've renovated the auditorium. It should look amazing now.",
  //   ),
  //   TextMessage(
  //     id: '15',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368014000),
  //     type: 'text',
  //     text: "That's great! I'm looking forward to checking it out.",
  //   ),
  //   TextMessage(
  //     id: '16',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368015000),
  //     type: 'text',
  //     text: "It's going to be a memorable event for sure.",
  //   ),
  //   TextMessage(
  //     id: '17',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368016000),
  //     type: 'text',
  //     text: 'By the way, have you heard from anyone else about the reunion?',
  //   ),
  //   TextMessage(
  //     id: '18',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368017000),
  //     type: 'text',
  //     text: 'I bumped into Lisa the other day, and she mentioned attending.',
  //   ),
  //   TextMessage(
  //     id: '19',
  //     senderId: 'sender2',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368018000),
  //     type: 'text',
  //     text: "That's great to hear. I hope many of our classmates can make it.",
  //   ),
  //   TextMessage(
  //     id: '20',
  //     senderId: 'sender1',
  //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368019000),
  //     type: 'text',
  //     text:
  //         'Yeah, it would be fantastic to catch up with everyone after all these years.',
  //   ),
  // ];

  void _addItem() {
    // _items.addAll([
    //   TextMessage(
    //     id: '${Random().nextInt(1000) + 1}',
    //     senderId: Random().nextInt(2) == 0 ? 'sender1' : 'sender2',
    //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368020000),
    //     text: lorem(paragraphs: 1, words: Random().nextInt(30) + 1),
    //   ),
    //   TextMessage(
    //     id: '${Random().nextInt(1000) + 1}',
    //     senderId: Random().nextInt(2) == 0 ? 'sender1' : 'sender2',
    //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368020000),
    //     text: lorem(paragraphs: 1, words: Random().nextInt(30) + 1),
    //   ),
    //   TextMessage(
    //     id: '${Random().nextInt(1000) + 1}',
    //     senderId: Random().nextInt(2) == 0 ? 'sender1' : 'sender2',
    //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368020000),
    //     text: lorem(paragraphs: 1, words: Random().nextInt(30) + 1),
    //   ),
    // ]);
    // _items.insert(
    //   5,
    //   TextMessage(
    //     id: '${Random().nextInt(1000) + 1}',
    //     senderId: 'sender2',
    //     timestamp: DateTime.fromMillisecondsSinceEpoch(1684368020000),
    //     text: lorem(paragraphs: 1, words: Random().nextInt(30) + 1),
    //   ),
    // );

    setState(() {
      _items.add(
        TextMessage(
          id: '${Random().nextInt(1000) + 1}',
          senderId: Random().nextInt(2) == 0 ? 'sender1' : 'sender2',
          timestamp: DateTime.fromMillisecondsSinceEpoch(1684368020000),
          text: lorem(paragraphs: 1, words: Random().nextInt(30) + 1),
        ),
      );
    });

    // if (_items.length > 1) {
    //   _theme = _theme.copyWith(fontName: 'Comic Sans MS');
    // }
  }

  // void _removeItem(types.Message item) {
  //   final index = _items.indexOf(item);

  //   if (index > -1) {
  //     setState(() {
  //       _items[index] =
  //           (_items[index] as types.TextMessage).copyWith(text: 'LOL');
  //       // _items.removeAt(index);
  //     });
  //   }
  // }

  // _controller.insert()

  // body: Chat(
  //     items: _items,
  //     initialItems: _items,
  //   ),

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _items,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addItem,
          tooltip: 'Add Item',
          child: const Icon(Icons.add),
        ),
      );
}

List<Message> generateTextMessages(int count) {
  final random = Random();
  final messages = <TextMessage>[];

  for (var i = 0; i < count; i++) {
    messages.add(
      TextMessage(
        id: i.toString(),
        senderId: (random.nextInt(2) == 0) ? 'sender1' : 'sender2',
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(1684368000000 + i * 1000),
        text: lorem(paragraphs: 1, words: random.nextInt(30) + 1),
        linkPreview: null,
      ),
    );
  }

  return messages;
}
