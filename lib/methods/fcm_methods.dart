import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:subtrack/methods/notification_methods.dart';
import 'package:subtrack/screens/settings_screen.dart';
import 'package:http/http.dart' as http;

class FcmMethods {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<AccessCredentials> accessServerKey() async {
    final serviceAccountPath = dotenv.env['PATH_TO_KEY'];
    String serviceAccountJson = await rootBundle.loadString(
      serviceAccountPath!,
    );
    final serviceAccount = ServiceAccountCredentials.fromJson(
      serviceAccountJson,
    );
    if (kDebugMode) {
      print("json: $serviceAccountJson");
    }

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(serviceAccount, scopes);
    return client.credentials;
  }

  Future<bool> sendPushNotification({
    required String deviceToken,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    if (deviceToken.isEmpty) return false;

    final credentials = await accessServerKey();
    final accessToken = credentials.accessToken.data;
    final projectId = dotenv.env['PROJECT_ID'];

    if (kDebugMode) {
      print("Access Token: ${credentials.accessToken.data}");
    }

    final url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
    );

    final message = {
      'message': {
        'token': deviceToken,
        'notification': {'title': title, 'body': body},
        'data': data ?? {},
      },
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Notification Successfully Sent!');
      }
      try {
        NotificationMethods().saveNotification(
          title: title,
          body: body,
          receivedAt: DateTime.now(),
        );
      } catch (e) {
        if (kDebugMode) {
          print("Error Saving Notification: ${e.toString()}");
        }
      }

      return true;
    } else {
      if (kDebugMode) {
        print('Failed to Send Notification: ${response.body}');
      }
      return false;
    }
  }

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
