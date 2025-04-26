import 'package:flutter/material.dart';

ThemeData getAppTheme() => ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Nunito",
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontFamily: "Nunito",
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w800,
    ),
  ),
);
