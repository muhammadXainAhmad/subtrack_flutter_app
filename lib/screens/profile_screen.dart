import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtrack/methods/upload_subscription_data_method.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainer,
        title: BuildText(
          text: FirebaseAuth.instance.currentUser!.displayName!,
          textSize: 20,
          textWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    radius: 32,
                  ),
                  InkWell(
                    onTap: () => uploadSubscriptionData(),
                    child: BuildText(
                      text: "Change profile picture",
                      textSize: 16,
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
