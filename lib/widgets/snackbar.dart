import 'package:flutter/material.dart';

void showSnackbarC(BuildContext context, String msg, Color bgColor, txtColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: TextStyle(color: txtColor),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: bgColor,
  ));
}
