import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static get themeData {
    return ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ));
  }
}
