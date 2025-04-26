// lib/core/theme/text_styles.dart
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyles {
  static TextStyle headline1(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 22),
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );
  static TextStyle headline2(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 20),
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  static TextStyle headline3(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 18),
    fontWeight: FontWeight.w900,
    color: AppColors.secondary,
  );

  static TextStyle headline4(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  static TextStyle headline5(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  static TextStyle bodyText1(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.normal,
    color: AppColors.secondary,
  );

  static TextStyle bodyText2(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 14),
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  static TextStyle primaryButton(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle secondaryButton(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, fontSize: 16),
    fontWeight: FontWeight.bold,
    color: AppColors.lightGreyBorder,
  );
}

double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 800;

  static late double width, height;

  static init(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
  }
}
