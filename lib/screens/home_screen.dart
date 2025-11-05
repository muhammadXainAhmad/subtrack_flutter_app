import 'package:flutter/material.dart';
import 'package:subtrack/screens/add_subscription_screen.dart';
import 'package:subtrack/screens/settings_screen.dart';
import 'package:subtrack/screens/subscription_details_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_bottom_navigation.dart';
import 'package:subtrack/widgets/segmented_button.dart';
import 'package:subtrack/widgets/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: floatingButton(colorScheme, context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigation(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            backgroundColor: colorScheme.surfaceContainer,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/images/faces18.png"),
                ),
                SizedBox(width: 10),
                BuildText(
                  text: "Welcome,\nXain Ahmad!",
                  textSize: 18,
                  textWeight: FontWeight.w700,
                ),
                /* 
            BuildText(
              text: "SubTrack .",
              textSize: 32,
              textWeight: FontWeight.w900,textFont: primaryFont,
            ),
            */
              ],
            ),
            actionsPadding: EdgeInsets.only(right: 6),
            actions: [
              _buildActionIcon(
                onPressed: () {},
                path: "history",
                colorScheme: colorScheme,
              ),
              _buildActionIcon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscriptionDetailsScreen(),
                    ),
                  );
                },
                path: "notification",
                colorScheme: colorScheme,
              ),
              _buildActionIcon(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    ),
                path: "settings",
                colorScheme: colorScheme,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                BgContainer(screenW: screenW, screenH: screenH),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Card(
                        color: colorScheme.surfaceContainerHigh,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: colorScheme.surfaceContainerLowest,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  BuildText(
                                    text: "Monthly Bills",
                                    textSize: 16,
                                  ),
                                  Spacer(),
                                  BuildText(text: "Daily", textSize: 12),
                                  SizedBox(width: 20),
                                  BuildText(text: "Weekly", textSize: 12),
                                  SizedBox(width: 20),
                                  BuildText(text: "Monthly", textSize: 12),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const BuildText(
                                    text: "\$1,532",
                                    textSize: 32,
                                    textWeight: FontWeight.w700,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor: colorScheme.surface,
                                      side: BorderSide(
                                        color:
                                            colorScheme.surfaceContainerLowest,
                                        width: 1,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: BuildText(
                                      text: "View your stats",
                                      textSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              color: colorScheme.surfaceContainerHigh,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: colorScheme.surfaceContainerLowest,
                                ),
                              ),
                              child: const SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 14,
                                  ),
                                  child: Column(
                                    children: [
                                      BuildText(
                                        text: "Maximum Subs",
                                        textSize: 14,
                                        textWeight: FontWeight.w500,
                                      ),
                                      BuildText(
                                        text: "\$80",
                                        textSize: 26,
                                        textWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              color: colorScheme.surfaceContainerHigh,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: colorScheme.surfaceContainerLowest,
                                ),
                              ),
                              child: const SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 14,
                                  ),
                                  child: Column(
                                    children: [
                                      BuildText(
                                        text: "Active Subs",
                                        textSize: 14,
                                        textWeight: FontWeight.w500,
                                      ),
                                      BuildText(
                                        text: "10",
                                        textSize: 26,
                                        textWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const CustomSegmentedButton(),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: 10, (
              context,
              index,
            ) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: ListTile(
                  tileColor: colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: colorScheme.surfaceContainerHigh),
                  ),
                  leading: const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage("assets/images/faces18.png"),
                  ),
                  title: const BuildText(text: "Spotify Premium", textSize: 14),
                  subtitle: const BuildText(
                    text: "Expires in 3 days",
                    textSize: 12,
                    textClr: Colors.red,
                  ),
                  trailing: const BuildText(text: "\$9.99 / MO", textSize: 12),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  FloatingActionButton floatingButton(
    ColorScheme colorScheme,
    BuildContext context,
  ) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSubscriptionScreen()),
          ),
      backgroundColor: colorScheme.surfaceContainer,
      child: customSvg(path: "add", colorScheme: colorScheme, width: 32),
    );
  }

  IconButton _buildActionIcon({
    required VoidCallback onPressed,
    required String path,
    required ColorScheme colorScheme,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: customSvg(path: path, colorScheme: colorScheme),
    );
  }
}
