import 'package:flutter/material.dart';
import 'package:flutter_practice/routes/Routes.dart';
import 'package:flutter_practice/widgets/ElevatedButtonWidget.dart';
import 'package:flutter_practice/utilities/showSnackBar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void moveToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(child:
    ElevatedButtonWidget(textData: "Show Snack Bar", onPressed: () {
      showSnackBar(context,()=> {
       moveToHomeScreen(context)
      },"Are you sure you want to move home screen ?");
    },));
  }
}
