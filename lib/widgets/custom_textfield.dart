import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.screenW,
    required this.controller,
    required this.textInputType,
    this.textCapitalization,
    required this.isPassoword,
  });
  final String hintText;
  final double screenW;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextCapitalization? textCapitalization;
  final bool isPassoword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenW * 0.85,
      height: 60,
      child: TextField(
        obscureText: isPassoword ? true : false,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        keyboardType: textInputType,
        style: TextStyle(color: whiteClr, fontSize: 15),
        controller: controller,
        decoration: InputDecoration(
          fillColor: transparentClr,
          hintText: hintText,
          hintStyle: TextStyle(color: whiteClr, fontSize: 15),
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: buttonBorder, width: 1.8),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: buttonBorder, width: 1.8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
