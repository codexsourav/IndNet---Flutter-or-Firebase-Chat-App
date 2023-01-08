import 'package:flutter/material.dart';

Widget MyButton({
  required Widget name,
  required ontap,
  Color? color = Colors.black,
  bool desabl = false,
  double borderRadiusVal = 50,
}) {
  return GestureDetector(
    onTap: !desabl ? ontap : null,
    child: Container(
      width: double.infinity,
      height: 55.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadiusVal),
      ),
      child: Center(
        child: name,
      ),
    ),
  );
}
