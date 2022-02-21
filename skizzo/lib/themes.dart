import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kScaffoldColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(
      color: kTextColor,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    headline1: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: kButtonColor,
      letterSpacing: -1,
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.orange[400]!,
  );
}
