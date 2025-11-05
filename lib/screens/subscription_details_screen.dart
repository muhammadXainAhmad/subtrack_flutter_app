import 'package:flutter/material.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_app_bar.dart';
import 'package:subtrack/widgets/custom_elevated_button.dart';
import 'package:subtrack/widgets/text.dart';

class SubscriptionDetailsScreen extends StatelessWidget {
  const SubscriptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(text: "Subscription Details"),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("assets/images/faces18.png"),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildText(text: "Spotify Premium", textSize: 18),
                          BuildText(
                            text: "Expires in 3 days",
                            textSize: 12,
                            textClr: Colors.red,
                          ),
                          Text(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            "Spotify Premium is a paid subscription plan that offers an enhanced music streaming experience without ads. It allows users to download songs for offline listening, enjoy unlimited skips, and stream in high-quality audio. Premium users can also play any track on demand and access exclusive features across all their devices.",
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildText(text: "Subscription Details", textSize: 16),
                    TextButton(
                      onPressed: () {},
                      child: BuildText(text: "Edit", textSize: 16),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.surfaceContainerLowest,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 14,
                    ),
                    child: Column(
                      children: [
                        detailsRow(
                          title: "Subscription Plan",
                          detail: "Essentials Plan - \$9.99",
                        ),
                        detailsRow(
                          title: "Subscription On",
                          detail: "04th Nov 2025",
                        ),
                        detailsRow(
                          title: "Payment Mode",
                          detail: "Auto-Renewal",
                        ),
                        detailsRow(title: "Billing Cycle", detail: "Monthly"),
                        detailsRow(
                          title: "Notifications",
                          detail: "2 days before",
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          screenW: screenW,
                          colorScheme: colorScheme,
                          text: "Renew",
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: CustomElevatedButton(
                          screenW: screenW,
                          colorScheme: colorScheme,
                          text: "Cancel",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding detailsRow({required String title, required String detail}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildText(text: title, textSize: 15),
          BuildText(text: detail, textSize: 15),
        ],
      ),
    );
  }
}
