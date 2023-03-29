import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String? textData;
  final VoidCallback onPressed;

  const ElevatedButtonWidget(
      {super.key, required this.textData, required this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(onPressed: onPressed, child: Text(textData!));
}
