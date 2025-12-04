import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subtrack/methods/fcm_methods.dart';
import 'package:subtrack/models/notification_model.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:uuid/uuid.dart';

class NotificationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FcmMethods _methods = FcmMethods();
  bool _initialized = false;

  void init(BuildContext context) {
    if (_initialized) return;
    _initialized = true;

    _methods.requestNotificationPermission();
    _methods.onTokenRefresh();
    _methods.firebaseInit(context);
    _methods.messageInteraction(context);
    _methods.getDeviceToken();
  }

  Future<void> saveNotification({
    required String title,
    required String body,
    required DateTime receivedAt,
  }) async {
    final String notificationId = Uuid().v1();
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("notifications")
        .doc(notificationId)
        .set(
          NotificationModel(
            id: notificationId,
            title: title,
            body: body,
            receivedAt: receivedAt,
          ).toMap(),
        );
  }

  Future<void> clearNotifications(BuildContext context) async {
    try {
      final snapshot =
          await _firestore
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .collection("notifications")
              .get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
      if (context.mounted) {
        showSnack(
          text: "All notifications cleared!",
          context: context,
          success: true,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(text: e.message ?? "Something went wrong.", context: context);
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(text: e.toString(), context: context);
      }
    }
  }
}
