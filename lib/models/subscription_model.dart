import 'package:subtrack/models/plan_model.dart';

class SubscriptionModel {
  final String subscriptionId;
  final String subscriptionName;
  final String paymentMode;
  final DateTime paymentDate;
  final DateTime nextPaymentDate;
  final String notificationAlert;
  final PlanModel plan;
  final String iconUrl;
  final String webUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubscriptionModel({
    required this.subscriptionId,
    required this.subscriptionName,
    required this.paymentMode,
    required this.paymentDate,
    required this.nextPaymentDate,
    required this.notificationAlert,
    required this.plan,
    required this.iconUrl,
    required this.webUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      subscriptionId: map["subscriptionId"] as String,
      subscriptionName: map['subscriptionName'] as String,
      paymentMode: map['paymentMode'] as String,
      paymentDate: map['paymentDate'] as DateTime,
      nextPaymentDate: map['nextPaymentDate'] as DateTime,
      notificationAlert: map['notificationAlert'] as String,
      plan: PlanModel.fromMap(map["plan"]),
      iconUrl: map['iconUrl'] as String,
       webUrl: map['webUrl'] as String,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subscriptionId": subscriptionId,
      "subscriptionName": subscriptionName,
      'paymentMode': paymentMode,
      'paymentDate': paymentDate,
      'nextPaymentDate': nextPaymentDate,
      'notificationAlert': notificationAlert,
      'plan': plan.toMap(),
      'iconUrl': iconUrl,
      'webUrl':webUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
