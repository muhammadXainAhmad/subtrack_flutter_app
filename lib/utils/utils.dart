import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const primaryFont = "DancingScript";

const buttonFill = Color(0xFF1C4EB5);
const buttonBorder = Color(0xFF1C4EB5);

const blackClr = Colors.black;
const whiteClr = Colors.white;
const transparentClr = Colors.transparent;

SvgPicture customSvg({
  required String path,
  required ColorScheme colorScheme,
  double? width,
}) {
  return SvgPicture.asset(
    "assets/icons/$path.svg",
    colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
    width: width,
  );
}

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
