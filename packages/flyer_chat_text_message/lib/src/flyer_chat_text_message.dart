import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:provider/provider.dart';

class FlyerChatTextMessage extends StatelessWidget {
  final TextMessage message;
  final bool isSentByMe;

  const FlyerChatTextMessage({
    super.key,
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    final fontName = context.select((ChatTheme theme) => theme.fontName);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isSentByMe ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: isSentByMe ? Colors.white : Colors.black,
          fontSize: 16,
          fontFamily: fontName,
        ),
      ),
    );
  }
}
