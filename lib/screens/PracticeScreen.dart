import 'package:flutter/material.dart';

class CallBackFunction extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CallBackFunction(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=> onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
