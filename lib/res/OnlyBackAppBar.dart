import 'package:flutter/material.dart';

PreferredSizeWidget OnlyBackAppbar(context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined,
            size: 18.0, color: Color.fromARGB(255, 12, 12, 12)),
        onPressed: () {
          Navigator.of(context).pop();
        }),
  );
}
