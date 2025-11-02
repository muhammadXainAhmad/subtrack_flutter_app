import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class LandingElevatedBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFilled;
  final double width;

  const LandingElevatedBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFilled = true,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    const buttonFill = Color(0xFF1C4EB5);
    const buttonBorder = Color(0xFF1C4EB5);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? buttonFill : Colors.transparent,
        foregroundColor: Colors.white,
        side:
            isFilled
                ? BorderSide.none
                : const BorderSide(color: buttonBorder, width: 1.8),
        minimumSize: Size(width * 0.7, 50),
        maximumSize: Size(width * 0.7, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: BuildText(
        text: text,
        textSize: 15,
        textClr: whiteClr,
        textWeight: FontWeight.w500,
      ),
    );
  }
}
