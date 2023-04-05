import 'package:flutter/material.dart';
import 'package:flutter_practice/routes/Routes.dart';
import 'package:flutter_practice/widgets/ElevatedButtonWidget.dart';
import '../utilities/showSnackBar.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  void moveToProductScreen(BuildContext context) {
    Navigator.pushNamed(context, productOverview);
  }


  @override
  Widget build(BuildContext context) {
    return  Center(child:
    ElevatedButtonWidget(textData: "Show Snack Bar", onPressed: () {
      showSnackBar(context,()=> {
        moveToProductScreen(context)
      },"Are you sure you want to move home screen ?");
    },));
  }
}
