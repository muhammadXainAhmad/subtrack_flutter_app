import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/glowing_circles.dart';
import 'package:subtrack/widgets/text.dart';

class LandingScreenTwo extends StatelessWidget {
  const LandingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: transparentClr,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120),
              GlowingCircles(screenW: screenW),
              const SizedBox(height: 120),
              const BuildText(
                text: "Split Subscriptions\nWith Your Friends",
                textClr: whiteClr,
                textSize: 24,
                textWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const BuildText(
                text:
                    "Split your subscriptions amongst friends and save a few extra bucks",
                textClr: whiteClr,
                textSize: 14,
                textWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
