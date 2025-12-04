import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:subtrack/screens/settings_screen.dart';

class NotificationMethods {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
    BuildContext context,
    RemoteMessage message,
  ) async {
    var androidInitializationSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      },
    );
  }

  // When app is in background
  Future<void> messageInteraction(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
      }
    });

    // When app is terminated
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    }
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print("NOTIFICATION TITLE: ${message.notification!.title.toString()}");
        print("NOTIFICATION BODY: ${message.notification!.body.toString()}");
        print("NOTIFICATION DATA: ${message.data.toString()}");
      }
      if (Platform.isAndroid && context.mounted) {
        initLocalNotifications(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: "Channel Description",
          importance: Importance.max,
          priority: Priority.high,
          ticker: "Ticker",
          icon: "@mipmap/ic_launcher",
        );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      1,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
    );
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void onTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print("TOKEN REFRESHED!");
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("PERMISSION GRANTED!");
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("PROVISIONAL PERMISSION GRANTED!");
      }
    } else {
      if (kDebugMode) {
        print("PERMISSION DENIED!");
      }
    }
  }
}

/*
For flutter_local_notifications: android\app\build.gradle.kts

android{
  compileOptions{
  isCoreLibraryDesugaringEnabled = true
  }
}
dependencies {
   coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

android\app\src\main\AndroidManifest.xml
Add under <application>:
  <meta-data
            android:name="com.google.firebase.messaging.default_notification_channel_id"
            android:value="high_importance_channel" />
 */
