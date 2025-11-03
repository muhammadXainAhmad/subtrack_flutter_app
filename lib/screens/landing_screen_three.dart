import 'package:flutter/material.dart';
import 'package:subtrack/screens/login_screen.dart';
import 'package:subtrack/screens/signup_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/landing_elevated_button.dart';
import 'package:subtrack/widgets/landing_notification_card.dart';
import 'package:subtrack/widgets/text.dart';

class LandingScreenThree extends StatelessWidget {
  const LandingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: transparentClr,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SizedBox(height: 20),
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
            LandingElevatedButton(
              isFilled: true,
              text: "Login",
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
              width: screenW,
            ),
            const SizedBox(height: 20),
            const BuildText(text: "OR", textSize: 14, textClr: whiteClr),
            const SizedBox(height: 20),
            LandingElevatedButton(
              isFilled: false,
              text: "Create a new account",
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  ),
              width: screenW,
            ),
          ],
        ),
      ),
    );
  }
}
