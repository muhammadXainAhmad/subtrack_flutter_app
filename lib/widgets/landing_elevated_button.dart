import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class LandingElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFilled;
  final double width;
  final bool isRow;
  final String? path;

  const LandingElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFilled = true,
    required this.width,
    this.isRow = false,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? buttonFill : Colors.transparent,
        foregroundColor: Colors.white,
        side:
            isFilled
                ? BorderSide.none
                : const BorderSide(color: buttonBorder, width: 1.8),
        fixedSize: Size(width * 0.85, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isRow) ...[
            Image.asset(path!, width: 30, height: 30),
            const SizedBox(width: 10),
          ],
          BuildText(
            text: text,
            textSize: 15,
            textClr: whiteClr,
            textWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
