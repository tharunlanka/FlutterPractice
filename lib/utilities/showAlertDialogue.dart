import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,{required String title,required String subTitle,required VoidCallback onClicked,}) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      onClicked();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(subTitle),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}