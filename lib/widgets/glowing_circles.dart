import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class GlowingCircles extends StatelessWidget {
  const GlowingCircles({super.key, required this.screenW});

  final double screenW;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // OUTER CIRCLE – faint, large glow that blends with the background
        Container(
          width: screenW * 0.7,
          height: screenW * 0.7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF0E3A7C).withAlpha(120), // dark neon blue tint
                Colors.transparent,
              ],
            ),
          ),
        ),

        // MIDDLE CIRCLE – more visible with bluish inner glow
        Container(
          width: screenW * 0.5,
          height: screenW * 0.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF164FCF).withAlpha(180), // bright edge-blue
                const Color(0xFF0A2A66).withAlpha(100), // dark navy transition
              ],
            ),
          ),
        ),

        // INNER CIRCLE – solid, vivid blue with soft neon glow
        Container(
          width: screenW * 0.3,
          height: screenW * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1565C0), // solid core blue
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF164FCF).withAlpha(220), // neon glow
                blurRadius: 25,
                spreadRadius: 6,
              ),
            ],
          ),
        ),
        const BuildText(
          text: "SubTrack .",
          textSize: 25,
          textClr: whiteClr,
          textWeight: FontWeight.w900,
          textFont: "DancingScript",
        ),
        Positioned(
          top: 65,
          right: 35,
          child: Image.asset(
            "assets/images/faces13.png",
            width: 50,
            height: 50,
          ),
        ),
        Positioned(
          top: 35,
          left: 65,
          child: Image.asset(
            "assets/images/faces15.png",
            width: 50,
            height: 50,
          ),
        ),
        Positioned(
          top: 230,
          right: 120,
          child: Image.asset(
            "assets/images/faces18.png",
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
