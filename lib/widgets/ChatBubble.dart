import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
      return DecoratedBox(
        // chat bubble decoration
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: isCurrentUser ? Colors.white : Colors.black87),
          ),
        ),
      );
    }
  }