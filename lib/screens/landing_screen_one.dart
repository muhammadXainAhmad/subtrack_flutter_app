import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class LandingScreenOne extends StatelessWidget {
  const LandingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: transparentClr,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            const BuildText(
              text: "Welcome to",
              textClr: whiteClr,
              textSize: 32,
              textAlign: TextAlign.center,
              textWeight: FontWeight.w700,
            ),
            const BuildText(
              text: "SubTrack .",
              textClr: whiteClr,
              textSize: 38,
              textAlign: TextAlign.center,
              textWeight: FontWeight.w900,
              textFont: primaryFont,
            ),
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/landing1.jpeg",
                fit: BoxFit.cover,
                width: screenW * 0.75,
                height: screenH * 0.35,
              ),
            ),
            const SizedBox(height: 40),
            const BuildText(
              text: "Manage Subscriptions\nLike A Pro",
              textClr: whiteClr,
              textSize: 24,
              textWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const BuildText(
              text:
                  "SubTrack lets you manage all your subscriptions effortlessly",
              textClr: whiteClr,
              textSize: 14,
              textWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
