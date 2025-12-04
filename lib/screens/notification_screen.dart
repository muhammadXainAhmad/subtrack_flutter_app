import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subtrack/methods/notification_methods.dart';
import 'package:subtrack/models/notification_model.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/custom_alert_dialog.dart';
import 'package:subtrack/widgets/custom_app_bar.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        text: "Notifications",
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: CustomTextButton(
              text: "Clear All",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      title: "Clear Notifications",
                      content:
                          "Are you sure you want to clear all notifications? This action cannot be reversed.",
                      btnText: "Clear",
                      onPressed: () async {
                        await NotificationMethods().clearNotifications(context);
                        if (context.mounted) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BgContainer(screenW: screenW, screenH: screenH),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: FutureBuilder(
              future:
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("notifications")
                      .orderBy("receivedAt", descending: true)
                      .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.onSurface,
                      strokeWidth: 1.5,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: BuildText(
                      text: "No notifications yet!",
                      textSize: 14,
                      textClr: Colors.grey,
                    ),
                  );
                }
                final snaps = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: snaps.length,
                  itemBuilder: (context, index) {
                    final notifsData = snaps[index].data();
                    final notifsModel = NotificationModel.fromMap(notifsData);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Material(
                        color: transparentClr,
                        child: ListTile(
                          minVerticalPadding: 14,
                          tileColor: colorScheme.surfaceContainerHigh,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              color: colorScheme.surfaceContainerLowest,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: colorScheme.surfaceContainerLowest,
                            child: customSvg(
                              path: "notification",
                              colorScheme: colorScheme,
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              text: notifsModel.title,
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  text:
                                      "    ${DateFormat("dd MMM yyyy").format(notifsModel.receivedAt)}",
                                ),
                              ],
                            ),
                          ),
                          subtitle: BuildText(
                            text: notifsModel.body,
                            textSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
