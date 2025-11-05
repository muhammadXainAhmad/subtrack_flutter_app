import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: NavigationBar(
          backgroundColor: colorScheme.surfaceContainer,
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: customSvg(path: "home", colorScheme: colorScheme),
              label: "home",
            ),
            NavigationDestination(
              icon: customSvg(path: "newspaper", colorScheme: colorScheme),
              label: "newspaper",
            ),
            NavigationDestination(
              icon: customSvg(path: "chart", colorScheme: colorScheme),
              label: "chart",
            ),
            NavigationDestination(
              icon: customSvg(path: "person", colorScheme: colorScheme),
              label: "person",
            ),
          ],
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
