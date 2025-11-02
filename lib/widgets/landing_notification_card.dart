import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class LandingNotificationCard extends StatelessWidget {
  final double width;
  final bool isTopCard;
  final bool isLastCard;
  const LandingNotificationCard({
    super.key,
    required this.width,
    required this.isTopCard,
    required this.isLastCard,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: const Color(0xFF0D1B2A).withValues(alpha: 0.6),
        margin: EdgeInsets.only(top: isTopCard ? 0 : 0.2),
        shape: RoundedRectangleBorder(
          borderRadius:
              isTopCard
                  ? BorderRadius.circular(20)
                  : const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isTopCard)
                const Row(
                  children: [
                    BuildText(
                      text: "SubTrack . ",
                      textSize: 13,
                      textWeight: FontWeight.w900,
                      textClr: whiteClr,
                      textFont: 'DancingScript',
                    ),
                    BuildText(
                      text: "Netflix Subscription",
                      textSize: 12,
                      textClr: Colors.red,
                    ),
                    Spacer(),
                    BuildText(text: "5m", textSize: 12, textClr: whiteClr),
                  ],
                ),
              const SizedBox(height: 2),
              BuildText(
                text: "Hi Xain!",
                textSize:
                    isTopCard
                        ? 13
                        : isLastCard
                        ? 11
                        : 12,
                textClr: whiteClr,
              ),
              BuildText(
                text:
                    isTopCard
                        ? "Your Netflix subscription expires in 2 days. To avoid in"
                        : isLastCard
                        ? "Your Youtube Premium payment failed. To try again,"
                        : "Your Spotify Premium auto-renewal has been turned",
                textSize:
                    isTopCard
                        ? 12
                        : isLastCard
                        ? 10
                        : 11,
                textClr: whiteClr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
