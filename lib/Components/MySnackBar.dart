import 'package:flutter/material.dart';

SnackBar MySnackBar(
    {required String title,
    Color BgColor = Colors.black,
    Icon icon = const Icon(Icons.favorite, color: Colors.white),
    required onclick,
    Icon iconame = const Icon(Icons.heart_broken_rounded)}) {
  return SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: BgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
              ),
              child: Text(title, style: const TextStyle(color: Colors.white)),
            ),
            const Spacer(),
            TextButton(
                onPressed: onclick,
                child: const Text(
                  "OK",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ))
          ],
        )),
  );
}
