import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget ShimmerBox(
    {double height = 10,
    double width = 10,
    double radius = 10,
    double magB = 0,
    double marR = 0,
    double magL = 0,
    double mrgT = 0}) {
  return SizedBox(
    child: Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Color.fromARGB(255, 241, 241, 241),
      highlightColor: Color.fromARGB(255, 255, 255, 255),
      child: Container(
        margin:
            EdgeInsets.only(bottom: magB, left: magL, right: marR, top: mrgT),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(radius),
        ),
        width: width,
        height: height,
      ),
    ),
  );
}
