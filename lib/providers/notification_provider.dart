import 'package:flutter/material.dart';
import 'package:subtrack/methods/notification_methods.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationMethods _methods = NotificationMethods();
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
}
