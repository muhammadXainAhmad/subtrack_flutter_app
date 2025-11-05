import 'package:flutter/material.dart';
import 'package:subtrack/widgets/add_subscription_dropdown.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_app_bar.dart';
import 'package:subtrack/widgets/custom_elevated_button.dart';

class AddSubscriptionScreen extends StatelessWidget {
  const AddSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(text: "Add a Subscription"),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  width: screenW,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.surfaceContainerLowest,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        AddSubscriptionDropdown(
                          title: "Subscription Name",
                          controller: nameController,
                          items: subscriptionNames,
                          path1: "search",
                          path2: "search",
                        ),
                        AddSubscriptionDropdown(
                          title: "Subscription Plan",
                          controller: nameController,
                          items: subscriptionPlans,
                          path1: "down",
                          path2: "up",
                        ),
                        AddSubscriptionDropdown(
                          title: "Payment Mode",
                          controller: nameController,
                          items: paymentModes,
                          path1: "down",
                          path2: "up",
                        ),
                        AddSubscriptionDropdown(
                          title: "Payment Date",
                          controller: nameController,
                          items: paymentDates,
                          path1: "calender",
                          path2: "calender",
                        ),
                        AddSubscriptionDropdown(
                          title: "Billing Cycle",
                          controller: nameController,
                          items: billingCycles,
                          path1: "down",
                          path2: "up",
                        ),
                        AddSubscriptionDropdown(
                          title: "Notification Alert",
                          controller: nameController,
                          items: alerts,
                          path1: "down",
                          path2: "up",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomElevatedButton(
                screenW: screenW * 1.05,
                colorScheme: colorScheme,
                text: "Add the Subscription",
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<String> subscriptionNames = [
  'Netflix',
  'Spotify',
  'YouTube Premium',
  'Amazon Prime Video',
  'Apple Music',
  'Disney+',
  'HBO Max',
  'Crunchyroll',
  'Canva Pro',
  'ChatGPT Plus',
  'Netflix',
  'Spotify',
  'YouTube Premium',
  'Amazon Prime Video',
  'Apple Music',
  'Disney+',
  'HBO Max',
  'Crunchyroll',
  'Canva Pro',
  'ChatGPT Plus',
];

final List<String> subscriptionPlans = [
  "Mobile - PKR 250",
  "Basic - PKR 450",
  "Standard - PKR 800",
  "Premium - PKR 1,100",
];
final List<String> paymentModes = [
  "Credit Card",
  "Debit Card",
  "JazzCash",
  "EasyPaisa",
];
final List<String> paymentDates = ["1st", "10th", "15th", "30th"];
final List<String> billingCycles = ["Monthly", "Quaterly", "Yearly"];
final List<String> alerts = ["1 Day Before", "3 Days Before", "1 Week Before"];
