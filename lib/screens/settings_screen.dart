import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_app_bar.dart';
import 'package:subtrack/widgets/custom_list_tile.dart';
import 'package:subtrack/widgets/text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(text: "Settings"),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                CustomListTile(
                  title: "Profile",
                  subtitle: "View and edit your profile",
                  iconPath: "person",
                  colorScheme: colorScheme,
                ),
                CustomListTile(
                  title: "Notification",
                  subtitle: "View your notifications",
                  iconPath: "notification",
                  colorScheme: colorScheme,
                ),
                CustomListTile(
                  title: "Rate",
                  subtitle: "Rate us",
                  iconPath: "star",
                  colorScheme: colorScheme,
                ),
                CustomListTile(
                  title: "FAQ",
                  subtitle: "Find your answers",
                  iconPath: "person",
                  colorScheme: colorScheme,
                ),
                CustomListTile(
                  title: "Help & Support",
                  subtitle: "Reach out to us",
                  iconPath: "person",
                  colorScheme: colorScheme,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenW * 0.35, 55),
                      backgroundColor: colorScheme.surfaceContainerLow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: colorScheme.surfaceContainerHigh,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        customSvg(path: "logout", colorScheme: colorScheme),
                        SizedBox(width: 10),
                        BuildText(
                          text: "Log Out",
                          textSize: 15,
                          textWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
