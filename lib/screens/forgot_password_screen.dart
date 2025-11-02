import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/custom_textfield.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/custom_elevated_button.dart';
import 'package:subtrack/widgets/text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();
    return LandingAnimateGradient(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: transparentClr,
          appBar: AppBar(
            backgroundColor: transparentClr,
            leading: IconButton(
              onPressed: // ******************************WILL HANDLE WITH PROVIDER********************************
                  () => Navigator.pop(context),
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
                                    text: "Forgot Password?",
                                    textSize: 24,
                                    textClr: whiteClr,
                                    textWeight: FontWeight.w700,
                                  ),
                                  Image.asset(
                                    "assets/images/forgotIllustration1.png",
                                  ),

                                  //  SizedBox(height: 20),

                                  // Image.asset(
                                  //   "assets/images/forgotIcon1.png",
                                  //   width: 70,
                                  //   height: 70,
                                  // ),

                                  // Image.asset(
                                  //   "assets/images/forgotIcon2.png",
                                  //   width: 120,
                                  //   height: 120,
                                  // ),
                                  // SizedBox(height: 20),
                                  const BuildText(
                                    text:
                                        "Dont worry! It happens. Please enter the email address associated with your account.",
                                    textClr: whiteClr,
                                    textSize: 14,
                                    textWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
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
                                  CustomElevatedButton(
                                    text: "Reset",
                                    isFilled: true,
                                    onPressed: () {},
                                    width: screenW,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(color: whiteClr),
                          CustomTextButton(
                            text: "Didn't receive email? Resend.",
                            onPressed: () {},
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
