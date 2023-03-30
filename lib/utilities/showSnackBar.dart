import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, VoidCallback onClicked,String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontFamily: 'Roboto'),
      ),
      action: SnackBarAction(
          label: 'OK',
          onPressed: () => {scaffold.hideCurrentSnackBar, onClicked()}),
    ),
  );
}
