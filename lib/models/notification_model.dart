import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime receivedAt;
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.receivedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map["id"] as String,
      title: map["title"] as String,
      body: map["body"] as String,
      receivedAt: (map["receivedAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "body": body, "receivedAt": receivedAt};
  }
}
