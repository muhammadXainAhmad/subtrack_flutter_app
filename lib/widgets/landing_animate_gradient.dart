import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';

class LandingAnimateGradient extends StatelessWidget {
  final Widget child;
  const LandingAnimateGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
      primaryBegin: Alignment.topLeft,
      primaryEnd: Alignment.bottomLeft,
      secondaryBegin: Alignment.bottomLeft,
      secondaryEnd: Alignment.topRight,
      primaryColors: animatePrimaryClrs,
      secondaryColors: animateSecondaryClrs,
      child: child,
    );
  }
}
