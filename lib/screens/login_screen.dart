import 'package:flutter/material.dart';
import 'package:subtrack/screens/landing_screen.dart';
import 'package:subtrack/screens/signup_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/custom_textfield.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/custom_elevated_button.dart';
import 'package:subtrack/widgets/text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return LandingAnimateGradient(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: transparentClr,
          appBar: AppBar(
            backgroundColor: transparentClr,
            leading: IconButton(
              onPressed: // ******************************WILL HANDLE WITH PROVIDER********************************
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LandingScreen(initialPage: 2),
                    ),
                  ),
              icon: Icon(Icons.arrow_back, color: whiteClr, size: 26),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BuildText(
                          text: "SubTrack .",
                          textSize: 38,
                          textClr: whiteClr,
                          textWeight: FontWeight.w900,
                          textFont: primaryFont,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          hintText: "Phone number or email address",
                          screenW: screenW,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          isPassoword: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          hintText: "Password",
                          screenW: screenW,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          isPassoword: true,
                        ),
                        const SizedBox(height: 10),
                        CustomElevatedButton(
                          text: "Log In",
                          isFilled: true,
                          onPressed: () {},
                          width: screenW,
                        ),
                        CustomTextButton(
                          text:
                              "Forgot your login details? Get help logging in.",
                          onPressed: () {},
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: const Divider(
                                color: whiteClr,
                                indent: 16,
                                endIndent: 10,
                              ),
                            ),
                            const BuildText(text: "OR", textSize: 14),
                            Expanded(
                              child: const Divider(
                                color: whiteClr,
                                indent: 10,
                                endIndent: 16,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        CustomElevatedButton(
                          text: "Continue with Google",
                          isFilled: false,
                          isRow: true,
                          path: "assets/images/googleLogo.png",
                          onPressed: () {},
                          width: screenW,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: whiteClr),
                CustomTextButton(
                  text: "Don't have an account? Sign up.",
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
