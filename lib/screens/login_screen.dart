import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/providers/authentication_provider.dart';
import 'package:subtrack/screens/forgot_password_screen.dart';
import 'package:subtrack/screens/phone_login_screen.dart';
import 'package:subtrack/screens/signup_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/custom_textfield.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/landing_elevated_button.dart';
import 'package:subtrack/widgets/text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                reverse: true,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                                    hintText: "Email address",
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
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    isPassoword: true,
                                  ),
                                  const SizedBox(height: 10),
                                  LandingElevatedButton(
                                    text: "Log In",
                                    isFilled: true,
                                    showLoader: authProvider.isLoading,
                                    width: screenW,
                                    onPressed: () async {
                                      final success = await authProvider
                                          .loginUserWithEmailPassword(
                                            emailController.text.trim(),
                                            passwordController.text.trim(),
                                            context,
                                          );
                                      if (context.mounted && success) {
                                        Navigator.of(
                                          context,
                                        ).popUntil((route) => route.isFirst);
                                      }
                                    },
                                  ),
                                  CustomTextButton(
                                    text:
                                        "Forgot your login details? Get help logging in.",
                                    onPressed:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    ForgotPasswordScreen(),
                                          ),
                                        ),
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
                                  LandingElevatedButton(
                                    text: "Continue with Google",
                                    isFilled: false,
                                    isRowImage: true,
                                    showLoaderG: authProvider.isLoading,
                                    path: "googleLogo.png",
                                    onPressed: () async {
                                      final success = await authProvider
                                          .googleSignIn(context);
                                      if (context.mounted && success) {
                                        Navigator.pop(context);
                                      }
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
                            text: "Don't have an account? Sign up.",
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
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
    );
  }
}
