import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class LandingElevatedButton extends StatelessWidget {
  final String text;
  final bool showLoader;
  final bool showLoaderG;
  final VoidCallback onPressed;
  final bool isFilled;
  final double width;
  final bool isRowImage;
  final String? path;

  const LandingElevatedButton({
    super.key,
    this.showLoader = false,
    this.showLoaderG = false,
    required this.text,
    required this.onPressed,
    this.isFilled = true,
    required this.width,
    this.isRowImage = false,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? buttonFill : Colors.transparent,
        foregroundColor: whiteClr,
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
          if (isRowImage && !showLoader && !showLoaderG) ...[
            Image.asset("assets/images/$path", width: 30, height: 30),
            const SizedBox(width: 10),
          ],
          showLoader
              ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: whiteClr,
                ),
              )
              : showLoaderG
              ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: whiteClr,
                ),
              )
              : BuildText(
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
