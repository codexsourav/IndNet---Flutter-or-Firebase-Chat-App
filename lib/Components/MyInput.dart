import 'package:flutter/material.dart';

Widget MyInput({
  required onChanged,
  required String hintText,
  controller = null,
  required Icon icon,
  prefixText = '',
  maxlen = null,
  TextInputType TextInputType = TextInputType.number,
  String counterText = "",
  double BorderRadiusVal = 50,
  int maxLinesVal = 1,
  Widget? lable,
  Widget? lableError,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      lable != null ? lable : SizedBox(),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 238, 238),
          borderRadius: BorderRadius.circular(BorderRadiusVal),
        ),
        child: TextField(
          maxLines: maxLinesVal,
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: TextInputType,
          onChanged: onChanged,
          maxLength: maxlen,
          decoration: InputDecoration(
              prefixText: prefixText,
              icon: icon,
              counterText: counterText,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(
                  left: prefixText.length != 0 ? 0 : 10,
                  bottom: 11,
                  top: 11,
                  right: 15),
              hintText: hintText),
        ),
      ),
      lableError != null ? lableError : SizedBox(),
    ],
  );
}
