import 'package:flutter/material.dart';

const blackClr = Colors.black;
const whiteClr = Colors.white;
const transparentClr = Colors.transparent;

ThemeData lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: "Inter",
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF0D47A1),
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18),
    ),
  );
}

ThemeData darkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Inter",
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF0D47A1),
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}

// Primary gradient for AnimateGradient (deep night neon look)
const animatePrimaryClrs = [
  Color(0xFF030B1A), // almost black with blue tint
  Color(0xFF061B3A), // dark navy blue
  Color(0xFF0E3A7C), // faint deep blue accent
];

// Secondary gradient for AnimateGradient (dark base blend)
const animateSecondaryClrs = [
  Colors.black, // pure black for depth
  Color(0xFF0A0A0A), // subtle dark grey
  Color(0xFF061B3A), // dark navy blend
];
