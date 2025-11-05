import 'package:flutter/material.dart';
import 'package:subtrack/widgets/text.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.screenW,
    required this.colorScheme,
    required this.text,
    required this.onPressed,
  });

  final double screenW;
  final ColorScheme colorScheme;
  final String text;
  final VoidCallback onPressed;

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
      child: BuildText(text: text, textSize: 15, textWeight: FontWeight.w500),
    );
  }
}
