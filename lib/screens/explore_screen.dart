import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subtrack/screens/explore_subscription_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/text.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainer,
        title: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: BuildText(
            text: "Explore",
            textSize: 20,
            textWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          FutureBuilder(
            future:
                firestore
                    .collection("subscriptions")
                    .orderBy("name", descending: false)
                    .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.onSurface,
                      strokeWidth: 1.5,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: BuildText(
                    text: "No subscriptions yet",
                    textSize: 14,
                    textClr: Colors.grey,
                  ),
                );
              }
              final subs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: subs.length,
                itemBuilder: (context, index) {
                  final sub = subs[index].data();
                  Color tileClr = Color(
                    int.parse(sub["color"].replaceAll("#", "0xFF")),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 12,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ExploreSubscriptionScreen(sub: sub),
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: colorScheme.surfaceContainerHigh,
                            ),
                          ),
                          tileColor: tileClr,
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: whiteClr,
                            child: ClipOval(
                              child: Image.network(
                                sub["iconUrl"],
                                width: 64,
                                height: 64,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          title: BuildText(
                            text: sub["name"],
                            textSize: 14,
                            textClr: whiteClr,
                            textWeight: FontWeight.w700,
                          ),
                          subtitle: BuildText(
                            text: sub["description"],
                            textSize: 12,
                            textClr: whiteClr,
                          ),
                          trailing: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BuildText(
                                text: sub["rating"].toString(),
                                textSize: 13,
                                textClr: whiteClr,
                              ),
                              SizedBox(width: 2),
                              customSvg(
                                path: "star",
                                colorScheme: colorScheme,
                                width: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
