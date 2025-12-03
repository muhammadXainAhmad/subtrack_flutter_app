import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/providers/bottom_nav_provider.dart';
import 'package:subtrack/screens/add_subscription_screen.dart';
import 'package:subtrack/screens/explore_screen.dart';
import 'package:subtrack/screens/home_screen.dart';
import 'package:subtrack/screens/profile_screen.dart';
import 'package:subtrack/screens/analytics_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/custom_bottom_navigation.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomNav = context.watch<BottomNavProvider>();
    final List<Widget> pages = [
      HomeScreen(),
      ExploreScreen(),
      AnalyticsScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      floatingActionButton: floatingButton(colorScheme, context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(index: bottomNav.currentIndex, children: pages),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
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
