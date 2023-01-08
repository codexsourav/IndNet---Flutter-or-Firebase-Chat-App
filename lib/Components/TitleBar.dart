import 'package:flutter/material.dart';

Widget TitleBar(String title) {
  return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
        child: Text(
          title,
          style: TextStyle(
              color: Color.fromARGB(255, 10, 10, 10),
              fontSize: 45.0,
              fontFamily: "Happy"),
        ),
      ));
}
