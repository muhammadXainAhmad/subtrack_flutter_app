import 'package:flutter/material.dart';
import 'package:subtrack/screens/landing_screen.dart';
import 'package:subtrack/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SubTrack',
      themeMode: ThemeMode.system,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      home: LandingScreen(),
    );
  }
}
