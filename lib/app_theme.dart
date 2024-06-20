import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      primary: Colors.greenAccent,
      background: Colors.white,
      onBackground: Colors.greenAccent,
      secondary: Colors.green,
      primaryContainer: Colors.green.shade50,
      onPrimaryContainer: Colors.green.shade100,
    ),
    textButtonTheme: const TextButtonThemeData(
      style:
          ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
    ),
  );
}

const TextStyle userPageNameTextTheme = TextStyle(fontSize: 30, fontFamily: "");
