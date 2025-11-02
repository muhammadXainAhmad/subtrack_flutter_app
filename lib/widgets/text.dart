import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  final String text;
  final Color? textClr;
  final double? textSize;
  final FontWeight? textWeight;
  final TextAlign? textAlign;
  final String? textFont;
  const BuildText({
    super.key,
    required this.text,
    this.textClr,
    required this.textSize,
    this.textWeight,
    this.textAlign,
    this.textFont,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: textClr ?? colorScheme.onSurface,
        fontSize: textSize,
        fontWeight: textWeight ?? FontWeight.normal,
        fontFamily: textFont
      ),
    );
  }
}
