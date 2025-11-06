import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/providers/authentication_provider.dart';
import 'package:subtrack/screens/login_screen.dart';
import 'package:subtrack/screens/phone_login_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/landing_elevated_button.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/custom_textfield.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/text.dart';

// COMBINE LOGIN AND SIGNUP INTO ONE & USE BOOL ISLOGIN?Combine LoginScreen & SignupScreen into 1 & use bool isLogin? (MAY OR MAY NOT)
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final screenW = MediaQuery.of(context).size.width;
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
                    Navigator.pop(context);
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
                                      hintText: "Email address",
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
                                      controller: passwordController,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      isPassoword: true,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextField(
                                      hintText: "Confirm Password",
                                      screenW: screenW,
                                      controller: confirmPasswordController,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      isPassoword: true,
                                    ),
                                    const SizedBox(height: 10),
                                    LandingElevatedButton(
                                      text: "Sign Up",
                                      isFilled: true,
                                      showLoader: authProvider.isLoading,
                                      width: screenW,
                                      onPressed: () async {
                                        final success = await authProvider
                                            .createUserWithEmailPassword(
                                              nameController.text.trim(),
                                              emailController.text.trim(),
                                              passwordController.text.trim(),
                                              confirmPasswordController.text
                                                  .trim(),
                                              context,
                                            );
                                        if (context.mounted && success) {
                                          Navigator.of(
                                            context,
                                          ).popUntil((route) => route.isFirst);
                                        }
                                      },
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
                                      isRowImage: true,
                                      showLoaderG: authProvider.isLoading,
                                      path: "googleLogo.png",
                                      onPressed: () {
                                        authProvider.googleSignIn(context);
                                      },
                                      width: screenW,
                                    ),
                                    const SizedBox(height: 10),
                                    LandingElevatedButton(
                                      text: "Continue with Phone",
                                      isFilled: false,
                                      isRowImage: true,
                                      path: "phone.png",
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => PhoneLoginScreen(),
                                          ),
                                        );
                                      },
                                      width: screenW,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(color: whiteClr),
                            CustomTextButton(
                              text: "Already have an account? Sign in.",
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
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
