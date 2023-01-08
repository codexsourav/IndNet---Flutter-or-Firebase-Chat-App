import 'package:flutter/material.dart';

Widget ProfileUserInfoBox(@required String type, @required String Info) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      type,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: 10.0),
    Text(
      Info,
      style: TextStyle(
        fontSize: 15.0,
      ),
    ),
    SizedBox(height: 18.0),
  ]);
}
