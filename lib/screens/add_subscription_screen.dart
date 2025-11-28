import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/providers/subscription_provider.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/add_subscription_dropdown.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_app_bar.dart';
import 'package:subtrack/widgets/custom_elevated_button.dart';
import 'package:subtrack/widgets/text.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<SubscriptionProvider>().fetchSubscriptionNames();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final subProvider = context.watch<SubscriptionProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        context.read<SubscriptionProvider>().reset();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: CustomAppBar(text: "Add a Subscription"),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AddSubscriptionDropdown(
                                  title: "Subscription Name",
                                  items: subProvider.subscriptionNames,
                                  selectedItem:
                                      subProvider.selectedSubscription,
                                  isEnabled: true,
                                  onChanged: (value) {
                                    if (value != null) {
                                      subProvider.selectSubscription(value);
                                    }
                                  },
                                  path1: "search",
                                  path2: "search",
                                ),
                                AddSubscriptionDropdown(
                                  title: "Subscription Plan",
                                  items:
                                      subProvider.plans
                                          .map((plan) => plan.toString())
                                          .toList(),
                                  isEnabled:
                                      subProvider.selectedSubscription != null,
                                  selectedItem:
                                      subProvider.selectedPlan?.toString(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      subProvider.selectPlan(value);
                                    }
                                  },
                                  path1: "down",
                                  path2: "up",
                                ),
                                AddSubscriptionDropdown(
                                  isEnabled:
                                      subProvider.selectedSubscription != null,
                                  onChanged: (value) {
                                    if (value != null) {
                                      subProvider.selectPayment(value);
                                    }
                                  },
                                  title: "Payment Mode",
                                  items: paymentModes,
                                  path1: "down",
                                  path2: "up",
                                ),
                                BuildText(
                                  text: "Payment Date",
                                  textSize: 16,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 10),
                                IgnorePointer(
                                  ignoring:
                                      subProvider.selectedSubscription == null,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await subProvider.selectDate(context);
                                    },
                                    child: Opacity(
                                      opacity:
                                          subProvider.selectedSubscription !=
                                                  null
                                              ? 1
                                              : 0.5,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        width: screenW,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color:
                                              colorScheme.surfaceContainerLow,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color:
                                                colorScheme
                                                    .surfaceContainerLowest,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BuildText(
                                              text:
                                                  subProvider.selectedDate !=
                                                          null
                                                      ? DateFormat(
                                                        "dd MMM yyyy",
                                                      ).format(
                                                        subProvider
                                                            .selectedDate!,
                                                      )
                                                      : "",
                                              textSize: 15,
                                            ),
                                            customSvg(
                                              path: "calendarSearch",
                                              colorScheme: colorScheme,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                BuildText(
                                  text: "Billing Cycle",
                                  textSize: 16,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 10),
                                Opacity(
                                  opacity:
                                      subProvider.selectedSubscription != null
                                          ? 1
                                          : 0.5,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    width: screenW,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: colorScheme.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color:
                                            colorScheme.surfaceContainerLowest,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BuildText(
                                          text:
                                              subProvider
                                                  .selectedBillingCycle ??
                                              "",
                                          textSize: 15,
                                        ),
                                        customSvg(
                                          path: "calendarSync",
                                          colorScheme: colorScheme,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                AddSubscriptionDropdown(
                                  isEnabled:
                                      subProvider.selectedSubscription != null,
                                  onChanged: (value) {
                                    if (value != null) {
                                      subProvider.selectNotificaition(value);
                                    }
                                  },
                                  title: "Notification Alert",
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
                        showLoader: subProvider.isLoading,
                        onPressed: () async {
                          if (subProvider.selectedSubscription == null ||
                              subProvider.selectedPayment == null ||
                              subProvider.selectedDate == null ||
                              subProvider.selectedNotification == null ||
                              subProvider.selectedPlan == null) {
                            showSnack(
                              text: "Please fill all fields!",
                              context: context,
                            );
                            return;
                          }
                          final success = await subProvider.addSubscription(
                            context: context,
                            currentUserId:
                                FirebaseAuth.instance.currentUser!.uid,
                            subscriptionName: subProvider.selectedSubscription!,
                            paymentMode: subProvider.selectedPayment!,
                            paymentDate: subProvider.selectedDate!,
                            notificationAlert:
                                subProvider.selectedNotification!,
                            plan: subProvider.selectedPlan!,
                          );
                          if (success && context.mounted) {
                            context.read<SubscriptionProvider>().reset();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<String> paymentModes = [
  "Credit Card",
  "Debit Card",
  "Mobile Wallets",
];
final List<String> alerts = ["1 Day Before", "3 Days Before", "1 Week Before"];
