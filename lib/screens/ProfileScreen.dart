import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/ElevatedButtonWidget.dart';
import 'package:flutter_practice/utilities/showSnackBar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child:
    ElevatedButtonWidget(textData: "Back", onPressed: () { 
      showSnackBar(context,() {
        // write your function when action happen in snack bar
      },"Showing Snack bar ");
    },));
  }
}
