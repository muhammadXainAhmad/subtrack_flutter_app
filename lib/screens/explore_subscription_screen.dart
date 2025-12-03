import 'package:flutter/material.dart';
import 'package:subtrack/methods/helper_methods.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_app_bar.dart';
import 'package:subtrack/widgets/text.dart';

class ExploreSubscriptionScreen extends StatelessWidget {
  final Map<String, dynamic> sub;
  const ExploreSubscriptionScreen({super.key, required this.sub});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final Color subClr = Color(int.parse(sub["color"].replaceAll("#", "0xFF")));
    return Scaffold(
      appBar: CustomAppBar(
        text: sub["name"],
        isCenter: true,
        bgClr: subClr,
        textClr: whiteClr,
        textSize: 22,
        onTap: () async {
          openLink(sub["website"]);
        },
      ),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH, clr: subClr),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 48,
                  backgroundColor: whiteClr,
                  child: ClipOval(
                    child: Image.network(
                      sub["iconUrl"],
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildText(
                      text: sub["category"],
                      textSize: 14,
                      textClr: whiteClr,
                    ),
                    const SizedBox(width: 5),
                    BuildText(text: "\u007C", textSize: 14, textClr: whiteClr),
                    const SizedBox(width: 5),
                    BuildText(
                      text: sub["rating"].toString(),
                      textSize: 14,
                      textClr: whiteClr,
                    ),
                    const SizedBox(width: 2),
                    customSvg(
                      path: "star",
                      colorScheme: colorScheme,
                      width: 12,
                      clr: whiteClr,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                BuildText(
                  text: sub["description"],
                  textSize: 14,
                  textClr: whiteClr,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: screenH * 0.33,
            left: 18,
            right: 18,
            child: Center(
              child: Column(
                children: [
                  BuildText(
                    text: "Features",
                    textSize: 20,
                    textWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 15),
                  BuildText(
                    text: (sub["features"] as List).join(" \u00B7 "),
                    textSize: 14,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  BuildText(
                    text: "Available Plans",
                    textSize: 20,
                    textWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 150,
                    width: screenW,
                    child: ListView.builder(
                      itemCount: sub["plans"].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final plan = sub["plans"][index];
                        return Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: subClr,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildText(
                                text: plan["name"],
                                textSize: 16,
                                textClr: whiteClr,
                                textWeight: FontWeight.w700,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              BuildText(
                                text: "${plan["currency"]} ${plan["price"]}",
                                textSize: 14,
                                textClr: whiteClr,
                              ),
                              const SizedBox(height: 8),
                              BuildText(
                                text: plan["billingCycle"],
                                textSize: 13,
                                textClr: whiteClr,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
