import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:subtrack/screens/landing_screen_one.dart';
import 'package:subtrack/screens/landing_screen_three.dart';
import 'package:subtrack/screens/landing_screen_two.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/text.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 0);
    return LandingAnimateGradient(
      child: Scaffold(
        backgroundColor: transparentClr,
        appBar: AppBar(
          centerTitle: true,
          title: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: whiteClr,
              dotColor: Colors.white38,
              spacing: 6,
            ),
          ),
          backgroundColor: transparentClr,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: TextButton(
                onPressed: () => controller.jumpToPage(2),
                child: const BuildText(
                  text: "Skip",
                  textSize: 15,
                  textClr: whiteClr,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: controller,
                children: const [
                  LandingScreenOne(),
                  LandingScreenTwo(),
                  LandingScreenThree(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
