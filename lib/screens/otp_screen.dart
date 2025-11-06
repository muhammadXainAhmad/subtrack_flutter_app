import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/providers/authentication_provider.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/landing_animate_gradient.dart';
import 'package:subtrack/widgets/text.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
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
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const BuildText(
                                    text: "Verification",
                                    textSize: 24,
                                    textClr: whiteClr,
                                    textWeight: FontWeight.w700,
                                  ),
                                  SizedBox(height: 30),
                                  BuildText(
                                    text:
                                        "Please enter the code sent to the number\n\n${widget.phoneNumber}",
                                    textClr: whiteClr,
                                    textSize: 14,
                                    textWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 30),
                                  Pinput(
                                    length: 6,
                                    controller: otpController,
                                    closeKeyboardWhenCompleted: true,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusedPinTheme,
                                    submittedPinTheme: submittedPinTheme,
                                    onCompleted: (pin) async {
                                      authProvider.verifyOtp(
                                        otp: pin,
                                        context: context,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(color: whiteClr),
                          CustomTextButton(
                            text: "Didn't receive code? Resend.",
                            onPressed: () {
                              authProvider.signInPhone(
                                context,
                                widget.phoneNumber,
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

final defaultPinTheme = PinTheme(
  width: 54,
  height: 54,
  textStyle: TextStyle(
    fontSize: 20,
    color: whiteClr,
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: buttonBorder),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: whiteClr),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(color: buttonFill),
);
