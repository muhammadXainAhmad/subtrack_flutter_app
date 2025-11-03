import 'package:flutter/material.dart';
import 'package:subtrack/screens/landing_screen.dart';
import 'package:subtrack/screens/login_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/landing_elevated_button.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/custom_textfield.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/text.dart';

// COMBINE LOGIN AND SIGNUP INTO ONE & USE BOOL ISLOGIN?
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController1 = TextEditingController();
    TextEditingController passwordController2 = TextEditingController();
    return LandingAnimateGradient(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: transparentClr,
          appBar: AppBar(
            backgroundColor: transparentClr,
            leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Future.delayed(const Duration(milliseconds: 120), () {
                  if (context.mounted) {
                    // ******************************WILL HANDLE WITH PROVIDER********************************
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const LandingScreen(initialPage: 2),
                      ),
                    );
                  }
                });
              },
              icon: Icon(Icons.arrow_back, color: whiteClr, size: 26),
            ),
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
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
                                      hintText: "Full Name",
                                      screenW: screenW,
                                      controller: nameController,
                                      textInputType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      isPassoword: false,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextField(
                                      hintText: "Phone number or email address",
                                      screenW: screenW,
                                      controller: emailController,
                                      textInputType: TextInputType.emailAddress,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      isPassoword: false,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextField(
                                      hintText: "Password",
                                      screenW: screenW,
                                      controller: passwordController1,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      isPassoword: true,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextField(
                                      hintText: "Confirm Password",
                                      screenW: screenW,
                                      controller: passwordController2,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      isPassoword: true,
                                    ),
                                    const SizedBox(height: 10),
                                    LandingElevatedButton(
                                      text: "Sign Up",
                                      isFilled: true,
                                      onPressed: () {},
                                      width: screenW,
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: const Divider(
                                            color: whiteClr,
                                            indent: 16,
                                            endIndent: 10,
                                          ),
                                        ),
                                        const BuildText(
                                          text: "OR",
                                          textSize: 14,
                                        ),
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
                                    LandingElevatedButton(
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
                              text: "Already have an account? Sign in.",
                              onPressed:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
