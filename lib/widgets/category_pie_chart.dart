import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/methods/helper_methods.dart';
import 'package:subtrack/providers/chart_provider.dart';
import 'package:subtrack/providers/subscription_provider.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class CategoryPieChart extends StatelessWidget {
  const CategoryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final provider = context.watch<ChartProvider>();
    final subProvider = context.watch<SubscriptionProvider>();
    return provider.isLoading
        ? Center(
          child: CircularProgressIndicator(
            color: colorScheme.onSurface,
            strokeWidth: 1.5,
          ),
        )
        : Column(
          children: [
            if (provider.categoryPrices.isEmpty)
              BuildText(text: "No subscriptions yet", textSize: 16)
            else
              SizedBox(
                width: 250,
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        sections:
                            provider.categoryPrices.entries
                                .toList()
                                .asMap()
                                .entries
                                .map((entry) {
                                  int idx = entry.key;
                                  MapEntry<String, double> e = entry.value;

                                  double total = provider.categoryPrices.values
                                      .fold(0, (sum, val) => sum + val);
                                  double percent = (e.value / total) * 100;

                                  return PieChartSectionData(
                                    color:
                                        provider.pieChartSectionColors[idx %
                                            provider
                                                .pieChartSectionColors
                                                .length],
                                    value: e.value,
                                    title: "${percent.toStringAsFixed(1)}%",
                                    radius: 45,
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: whiteClr,
                                    ),
                                  );
                                })
                                .toList(),
                      ),
                    ),
                    BuildText(
                      text: formatPKR(subProvider.monthlyTotal!),
                      textSize: 22,
                      textWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 30),
            // Horizontally scrollable legend
            SizedBox(
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.categoryPrices.length,
                itemBuilder: (context, idx) {
                  final e = provider.categoryPrices.entries.toList()[idx];
                  final count = provider.categoryCounts[e.key];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                provider.pieChartSectionColors[idx %
                                    provider.pieChartSectionColors.length],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            child: Text(
                              "${e.key} - PKR ${e.value.toStringAsFixed(0)} ($count ${count == 1 ? "sub" : "subs"})",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
  }
}
