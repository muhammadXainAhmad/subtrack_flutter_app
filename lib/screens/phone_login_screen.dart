import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/providers/authentication_provider.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/custom_textfield.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/landing_elevated_button.dart';
import 'package:subtrack/widgets/text.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
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
              onPressed: () => Navigator.pop(context),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const BuildText(
                                  text: "Login with Phone",
                                  textSize: 24,
                                  textClr: whiteClr,
                                  textWeight: FontWeight.w700,
                                ),
                                Image.asset(
                                  "assets/images/otp.png",
                                  width: 150,
                                  height: 200,
                                ),
                                const BuildText(
                                  text:
                                      "Please enter your phone number (+92 300 1234567) to receive a one time password.",
                                  textClr: whiteClr,
                                  textSize: 14,
                                  textWeight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  hintText: "Phone number",
                                  screenW: screenW,
                                  controller: phoneController,
                                  textInputType: TextInputType.phone,
                                  textCapitalization: TextCapitalization.none,
                                  isPassoword: false,
                                ),
                                const SizedBox(height: 10),
                                LandingElevatedButton(
                                  text: "Send OTP",
                                  isFilled: true,
                                  showLoader: authProvider.isLoading,
                                  width: screenW,
                                  onPressed: () async {
                                    await authProvider.signInPhone(
                                      context,
                                      phoneController.text.trim(),
                                    );
                                  },
                                ),
                              ],
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
    );
  }
}
