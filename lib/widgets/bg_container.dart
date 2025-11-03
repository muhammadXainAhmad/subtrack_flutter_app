import 'package:flutter/material.dart';

class BgContainer extends StatelessWidget {
  final double screenW;
  final double screenH;
  final Color color;
  final String? path;
  const BgContainer({
    super.key,
    required this.screenW,
    required this.screenH,
    required this.color,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenW,
      height: screenH * 0.3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    );
  }
}
