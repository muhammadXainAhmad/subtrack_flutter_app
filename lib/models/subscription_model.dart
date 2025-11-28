import 'package:subtrack/models/plan_model.dart';

class SubscriptionModel {
  final String subscriptionId;
  final String subscriptionName;
  final String paymentMode;
  final DateTime paymentDate;
  final String notificationAlert;
  final PlanModel plan;

  SubscriptionModel({
    required this.subscriptionId,
    required this.subscriptionName,
    required this.paymentMode,
    required this.paymentDate,
    required this.notificationAlert,
    required this.plan,
  });

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      subscriptionId: map["subscriptionId"] as String,
      subscriptionName: map['subscriptionName'] as String,
      paymentMode: map['paymentMode'] as String,
      paymentDate: map['paymentDate'] as DateTime,
      notificationAlert: map['notificationAlert'] as String,
      plan: PlanModel.fromMap(map["plan"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subscriptionId": subscriptionId,
      "subscriptionName": subscriptionName,
      'paymentMode': paymentMode,
      'paymentDate': paymentDate,
      'notificationAlert': notificationAlert,
      'plan': plan.toMap(),
    };
  }
}
