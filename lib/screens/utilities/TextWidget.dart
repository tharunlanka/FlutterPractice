import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String? textData;

   const TextWidget({super.key, required this.textData});

  @override
  Widget build(BuildContext context) => Center(heightFactor: 3,
    child:Text(textData!, textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18, color: Colors.black87,
        fontFamily: 'Roboto',
      ),),);
}