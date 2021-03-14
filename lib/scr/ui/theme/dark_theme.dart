import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/ui/global/app_colors.dart';

ThemeData darkThemeData = ThemeData(
  primaryColor: darkPrimaryColor,
  backgroundColor: darkBackgroundColor,
  focusColor: textColor,
  disabledColor: darkDisabledColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    button: TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  ),
);