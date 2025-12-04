import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/methods/helper_methods.dart';
import 'package:subtrack/models/subscription_model.dart';
import 'package:subtrack/providers/subscription_provider.dart';
import 'package:subtrack/screens/add_subscription_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_app_bar.dart';
import 'package:subtrack/widgets/custom_elevated_button.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/text.dart';
import 'package:intl/intl.dart';

class SubscriptionDetailsScreen extends StatelessWidget {
  final SubscriptionModel subscriptionData;
  const SubscriptionDetailsScreen({super.key, required this.subscriptionData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final subProvider = context.read<SubscriptionProvider>();
    final renewalDays =
        subscriptionData.nextPaymentDate
            .difference(subscriptionData.paymentDate)
            .inDays;
    return Scaffold(
      appBar: CustomAppBar(text: "Subscription Details"),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: whiteClr,
                      child: ClipOval(
                        child: Image.network(
                          subscriptionData.iconUrl,
                          width: 64,
                          height: 64,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => openLink(subscriptionData.webUrl),
                            child: BuildText(
                              text: subscriptionData.subscriptionName,
                              textSize: 18,
                              textWeight: FontWeight.w900,
                            ),
                          ),
                          BuildText(
                            text:
                                renewalDays > 7
                                    ? "Renewal on ${DateFormat("dd MMM yyyy").format(subscriptionData.nextPaymentDate)}"
                                    : "Expires in $renewalDays days",
                            textSize: 12,
                            textClr:
                                renewalDays > 7
                                    ? colorScheme.onSurface
                                    : Colors.red,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildText(
                      text: "Subscription Details",
                      textSize: 16,
                      textWeight: FontWeight.w600,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AddSubscriptionScreen(
                                  isEdit: true,
                                  editData: subscriptionData,
                                ),
                          ),
                        );
                      },
                      child: BuildText(
                        text: "Edit",
                        textSize: 16,
                        textWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.surfaceContainerLowest,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 14,
                    ),
                    child: Column(
                      children: [
                        detailsRow(
                          title: "Subscription Plan",
                          detail: subscriptionData.plan.name,
                        ),
                        detailsRow(
                          title: "Subscription Price",
                          detail:
                              " ${subscriptionData.plan.currency} ${subscriptionData.plan.price}",
                        ),
                        detailsRow(
                          title: "Renewal Date",
                          detail: DateFormat(
                            "dd MMM yyyy",
                          ).format(subscriptionData.nextPaymentDate),
                        ),
                        detailsRow(
                          title: "Last Payment Date",
                          detail:
                              DateFormat(
                                "dd MMM yyyy",
                              ).format(subscriptionData.paymentDate).toString(),
                        ),
                        detailsRow(
                          title: "Payment Mode",
                          detail: subscriptionData.paymentMode,
                        ),
                        detailsRow(
                          title: "Billing Cycle",
                          detail: subscriptionData.plan.billingCycle,
                        ),
                        detailsRow(
                          title: "Notification Alert",
                          detail: subscriptionData.notificationAlert,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          screenW: screenW,
                          colorScheme: colorScheme,
                          text: "Renew",
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: CustomElevatedButton(
                          screenW: screenW,
                          colorScheme: colorScheme,
                          showLoader: subProvider.isLoading,
                          text: "Cancel",
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.bottomCenter,
                                  actionsAlignment: MainAxisAlignment.center,
                                  backgroundColor:
                                      colorScheme.surfaceContainerHigh,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: colorScheme.surfaceContainerLowest,
                                    ),
                                  ),
                                  title: BuildText(
                                    textAlign: TextAlign.center,
                                    text:
                                        "Deleting ${subscriptionData.subscriptionName} Subscription",
                                    textSize: 16,
                                    textWeight: FontWeight.w600,
                                  ),
                                  content: BuildText(
                                    textAlign: TextAlign.center,
                                    text:
                                        "Are you sure you want to cancel this subscription? This action cannot be reversed.",
                                    textSize: 13,
                                  ),
                                  actions: [
                                    CustomTextButton(
                                      buttonStyle: TextButton.styleFrom(
                                        backgroundColor: Colors.green.shade200,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color:
                                                colorScheme.surfaceContainerLow,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      text: "Yes",
                                      onPressed: () async {
                                        await subProvider.deleteSubscription(
                                          context: context,
                                          subId:
                                              subscriptionData.subscriptionId,
                                          subName:
                                              subscriptionData.subscriptionName,
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 14),
                                    CustomTextButton(
                                      buttonStyle: TextButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color:
                                                colorScheme.surfaceContainerLow,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      text: "No",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding detailsRow({required String title, required String detail}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildText(text: title, textSize: 15),
          BuildText(text: detail, textSize: 15),
        ],
      ),
    );
  }
}
