import 'package:flutter/material.dart';

Widget AlertBox(String title, String message, String btntext, context) {
  return AlertDialog(
    backgroundColor: Color.fromARGB(255, 233, 233, 233),
    elevation: 0.0,
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(btntext))
    ],
  );
}
