import 'package:flutter/material.dart';

import 'colors.dart';

SizedBox verticalMargin(double height) {
  return SizedBox(
    height: height,
  );
}

OutlineInputBorder roundPurpleBorder(double radius) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: kPurple,
    ),
    borderRadius: BorderRadius.circular(radius),
  );
}
