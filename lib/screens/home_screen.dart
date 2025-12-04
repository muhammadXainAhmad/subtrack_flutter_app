import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/methods/helper_methods.dart';
import 'package:subtrack/models/subscription_model.dart';
import 'package:subtrack/providers/notification_provider.dart';
import 'package:subtrack/providers/segmented_btn_provider.dart';
import 'package:subtrack/providers/subscription_provider.dart';
import 'package:subtrack/providers/user_provider.dart';
import 'package:subtrack/screens/settings_screen.dart';
import 'package:subtrack/screens/subscription_details_screen.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/segmented_button.dart';
import 'package:subtrack/widgets/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationProvider>().init(context);
    final user = context.watch<UserProvider>().getUser;
    final subProvider = context.watch<SubscriptionProvider>();
    final segmentedBtnProvider = context.watch<SegmentedBtnProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return user == null
        ? Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: colorScheme.onSurface,
              strokeWidth: 1.5,
            ),
          ),
        )
        : Scaffold(
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
                    Expanded(
                      child: Text(
                        "Welcome,\n${user.fullName}",
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                actionsPadding: EdgeInsets.only(right: 6),
                actions: [
                  _buildActionIcon(
                    onPressed: () {},
                    path: "history",
                    colorScheme: colorScheme,
                    tooltipText: "Transaction History",
                  ),
                  _buildActionIcon(
                    onPressed: () {},
                    path: "notification",
                    colorScheme: colorScheme,
                    tooltipText: "Notifications",
                  ),
                  _buildActionIcon(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        ),
                    path: "settings",
                    colorScheme: colorScheme,
                    tooltipText: "Settings",
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
                                  Row(
                                    children: [
                                      BuildText(
                                        text: "${subProvider.view} Bill",
                                        textSize: 16,
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap:
                                            () => subProvider.setBillView(
                                              "Weekly",
                                            ),
                                        child: BuildText(
                                          text: "Weekly",
                                          textSize: 12,
                                          textDecoration:
                                              subProvider.view == "Weekly"
                                                  ? TextDecoration.underline
                                                  : null,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap:
                                            () => subProvider.setBillView(
                                              "Monthly",
                                            ),
                                        child: BuildText(
                                          text: "Monthly",
                                          textSize: 12,
                                          textDecoration:
                                              subProvider.view == "Monthly"
                                                  ? TextDecoration.underline
                                                  : null,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap:
                                            () => subProvider.setBillView(
                                              "Annual",
                                            ),
                                        child: BuildText(
                                          text: "Annual",
                                          textSize: 12,
                                          textDecoration:
                                              subProvider.view == "Annual"
                                                  ? TextDecoration.underline
                                                  : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    spacing: 12,
                                    runSpacing: 20,
                                    children: [
                                      BuildText(
                                        text:
                                            subProvider.view == "Weekly"
                                                ? formatPKR(
                                                  subProvider.weeklyTotal!,
                                                )
                                                : subProvider.view == "Monthly"
                                                ? formatPKR(
                                                  subProvider.monthlyTotal!,
                                                )
                                                : subProvider.view == "Annual"
                                                ? formatPKR(
                                                  subProvider.yearlyTotal!,
                                                )
                                                : '0',
                                        textSize: 26,
                                        textWeight: FontWeight.w700,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          backgroundColor: colorScheme.surface,
                                          side: BorderSide(
                                            color:
                                                colorScheme
                                                    .surfaceContainerLowest,
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
                                  child: SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 14,
                                      ),
                                      child: Column(
                                        children: [
                                          const BuildText(
                                            text: "Active Subs",
                                            textSize: 14,
                                            textWeight: FontWeight.w500,
                                          ),
                                          BuildText(
                                            text:
                                                subProvider.subCount.toString(),
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
              SliverToBoxAdapter(
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("users_subscriptions")
                          .orderBy("createdAt", descending: false)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 140),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.onSurface,
                            strokeWidth: 1.5,
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 140),
                        child: Center(
                          child: BuildText(
                            text: "No subscriptions added yet",
                            textSize: 14,
                            textClr: Colors.grey,
                          ),
                        ),
                      );
                    }
                    final subs = snapshot.data!.docs;
                    return Column(
                      children: List.generate(subs.length, (index) {
                        final dataMap = subs[index].data();
                        final subscriptionData = SubscriptionModel.fromMap(
                          dataMap,
                        );
                        final renewalDays =
                            subscriptionData.nextPaymentDate
                                .difference(subscriptionData.paymentDate)
                                .inDays;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => SubscriptionDetailsScreen(
                                        subscriptionData: subscriptionData,
                                      ),
                                ),
                              );
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              tileColor: colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: colorScheme.surfaceContainerHigh,
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 24,
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
                              title: BuildText(
                                text: subscriptionData.subscriptionName,
                                textSize: 14,
                              ),
                              subtitle: BuildText(
                                text:
                                    segmentedBtnProvider.selected ==
                                            "yourSubscriptions"
                                        ? "${subscriptionData.plan.name} Plan"
                                        : renewalDays > 7
                                        ? "Renewal on ${DateFormat("dd MMM yyyy").format(subscriptionData.nextPaymentDate)}"
                                        : "Expires in $renewalDays days",
                                textSize: 12,
                                textClr: renewalDays <= 7 ? Colors.red : null,
                              ),
                              trailing: BuildText(
                                text:
                                    "${subscriptionData.plan.currency} ${subscriptionData.plan.price} / ${subscriptionData.plan.billingCycle.toString().substring(0, 2).toUpperCase()}",
                                textSize: 12,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        );
  }

  Tooltip _buildActionIcon({
    required VoidCallback onPressed,
    required String path,
    required ColorScheme colorScheme,
    required String tooltipText,
  }) {
    return Tooltip(
      message: tooltipText,
      textStyle: TextStyle(color: colorScheme.onSurface),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.surfaceContainerLowest),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: customSvg(path: path, colorScheme: colorScheme),
      ),
    );
  }
}
