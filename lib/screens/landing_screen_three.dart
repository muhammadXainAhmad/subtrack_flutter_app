import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/landing_elevated_btn.dart';
import 'package:subtrack/widgets/landing_notification_card.dart';
import 'package:subtrack/widgets/text.dart';

class LandingScreenThree extends StatelessWidget {
  const LandingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return LandingAnimateGradient(
      child: Scaffold(
        backgroundColor: transparentClr,
        appBar: AppBar(backgroundColor: transparentClr),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LandingNotificationCard(
                width: screenW,
                isTopCard: true,
                isLastCard: false,
              ),
              LandingNotificationCard(
                width: screenW * 0.83,
                isTopCard: false,
                isLastCard: false,
              ),
              LandingNotificationCard(
                width: screenW * 0.75,
                isTopCard: false,
                isLastCard: true,
              ),
              const SizedBox(height: 100),
              const BuildText(
                text: "Get Notified and Never\nMiss a Renewal Date",
                textClr: whiteClr,
                textSize: 24,
                textWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const BuildText(
                text:
                    "Receive reminders so you'll never miss a subscription renewal again",
                textClr: whiteClr,
                textSize: 14,
                textWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),
              LandingElevatedBtn(
                isFilled: true,
                text: "Login",
                onPressed: () {},
                width: screenW,
              ),
              const SizedBox(height: 20),
              const BuildText(text: "or", textSize: 14, textClr: whiteClr),
              const SizedBox(height: 20),
              LandingElevatedBtn(
                isFilled: false,
                text: "Create a new account",
                onPressed: () {},
                width: screenW,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
