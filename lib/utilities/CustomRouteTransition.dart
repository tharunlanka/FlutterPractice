import 'package:flutter/material.dart';

PageRouteBuilder customRouteTransition(dynamic route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
