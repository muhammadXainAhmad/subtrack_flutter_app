import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.screenW,
    required this.colorScheme,
    required this.text,
    required this.onPressed,
    this.showLoader = false,
  });

  final double screenW;
  final ColorScheme colorScheme;
  final String text;
  final VoidCallback onPressed;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(screenW * 0.5, 55),
        backgroundColor: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: colorScheme.surfaceContainerHigh),
        ),
      ),
      onPressed: onPressed,
      child:
          showLoader
              ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: whiteClr,
                ),
              )
              : BuildText(
                text: text,
                textSize: 15,
                textWeight: FontWeight.w500,
              ),
    );
  }
}
