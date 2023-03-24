import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
 return Container(
   height: 120.0,
   width: 120.0,
   decoration: const BoxDecoration(
     image: DecorationImage(
       image: AssetImage(
           "images/img.png"),
       fit: BoxFit.fill,
     ),
     shape: BoxShape.rectangle,
   ),
 );
  }
}
