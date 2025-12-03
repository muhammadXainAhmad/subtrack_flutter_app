import 'package:flutter/material.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/category_pie_chart.dart';
import 'package:subtrack/widgets/text.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainer,
        title: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: BuildText(
            text: "Analytics",
            textSize: 20,
            textWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Center(
              child: Column(
                children: [CategoryPieChart(), SizedBox(height: 20)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
