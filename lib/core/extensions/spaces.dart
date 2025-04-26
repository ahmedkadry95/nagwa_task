import 'package:flutter/material.dart';

extension Spaces on Widget {
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }

  Widget withMargin(EdgeInsets margin) {
    return Container(margin: margin, child: this);
  }
}

extension MediaQueryHelper on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}

SizedBox heightSpace(double height) => SizedBox(height: height);

SizedBox widthSpace(double width) => SizedBox(width: width);
