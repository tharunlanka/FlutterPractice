import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     duration: const Duration(seconds: 8),
  //     vsync: this,
  //   )..repeat();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(vsync: this, duration: const Duration(seconds: 8));
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.yellow).animate(_controller);
    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat(); // repeat the animation when it completes

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: SizedBox(
            width: 300.0,
            height: 200.0,
             child: Image.asset('assets/images/img.png'),
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2.2 * 3.14,
              child: Center(
                child: Container(
                  height: sizeAnimation.value,
                  width: sizeAnimation.value,
                  color: colorAnimation.value,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: "https://cdn.pixabay.com/photo/2016/11/29/12/13/fence-1869401_1280.jpg",
                    fadeInCurve: Curves.easeInOut,
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
