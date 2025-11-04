import 'package:flutter/material.dart';

class BgContainer extends StatelessWidget {
  final double screenW;
  final double screenH;
  const BgContainer({super.key, required this.screenW, required this.screenH});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: screenW,
      height: screenH * 0.3,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    );
  }
}
