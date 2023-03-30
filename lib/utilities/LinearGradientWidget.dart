import 'package:flutter/material.dart';

class LinearGradientWidget extends StatelessWidget {
  final List<Color> gradientColors;
  final Widget child;

  const LinearGradientWidget(
      {super.key, required this.gradientColors, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 1),
            colors: gradientColors,
            tileMode: TileMode.mirror,
          ),
        ),
        child: child,
      ),
    );
  }
}
