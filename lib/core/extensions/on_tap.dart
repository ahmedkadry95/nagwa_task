import 'package:flutter/material.dart';

extension OnTap on Widget {
  Widget onTap(void Function()? onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }
}
