import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? buttonStyle;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: BuildText(text: text, textSize: 13, textClr: whiteClr),
    );
  }
}
