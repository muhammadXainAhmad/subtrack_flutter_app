import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:subtrack/models/plan_model.dart';
import 'package:subtrack/models/subscription_model.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class SubscriptionProvider with ChangeNotifier {
  SubscriptionProvider() {
    fetchActiveSubNumbers();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _subscriptionNames = [];
  List<PlanModel> _plans = [];
  List<String> _billingCycle = [];
  List<String> _paymentModes = [];
  List<String> _notificationAlerts = [];
  String? _selectedSubscription;
  PlanModel? _selectedPlan;
  String? _selectedPayment;
  String? _selectedBillingCycle;
  DateTime? _selectedDate;
  String? _selectedNotification;
  int? _subCount;

  List<String> get subscriptionNames => _subscriptionNames;
  List<PlanModel> get plans => _plans;
  List<String> get billingCycle => _billingCycle;
  List<String> get paymentModes => _paymentModes;
  List<String> get notificationAlerts => _notificationAlerts;
  String? get selectedSubscription => _selectedSubscription;
  PlanModel? get selectedPlan => _selectedPlan;
  String? get selectedPayment => _selectedPayment;
  String? get selectedBillingCycle => _selectedBillingCycle;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedNotification => _selectedNotification;
  int? get subCount => _subCount;

  Future<void> fetchSubscriptionNames() async {
    try {
      final snapshot = await _firestore.collection("subscriptions").get();
      _subscriptionNames =
          snapshot.docs.map((doc) => doc["name"] as String).toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error fetching subscription names: $e");
    }
  }

  Future<void> fetchPaymentModes() async {
    try {
      final snapshot = await _firestore.collection("paymentModes").get();
      _paymentModes =
          snapshot.docs.map((doc) => doc["label"] as String).toList();
    } catch (e) {
      if (kDebugMode) print("Error fetching payment modes: $e");
    }
  }

  Future<void> fetchNotificationAlerts() async {
    try {
      final snapshot = await _firestore.collection("notificationAlerts").get();
      _notificationAlerts =
          snapshot.docs.map((doc) => doc["label"] as String).toList();
    } catch (e) {
      if (kDebugMode) print("Error fetching notification alerts: $e");
    }
  }

  void reset() {
    _selectedSubscription = null;
    _selectedPlan = null;
    _selectedPayment = null;
    _selectedBillingCycle = null;
    _selectedDate = null;
    _selectedNotification = null;

    _plans = [];
    _billingCycle = [];

    notifyListeners();
  }

  Future<void> selectSubscription(String? subscriptionName) async {
    _selectedSubscription = subscriptionName;
    _plans = [];
    _selectedPlan = null;
    _billingCycle = [];
    _selectedBillingCycle = null;
    notifyListeners();

    if (subscriptionName == null) return;

    try {
      final docId = subscriptionName.toLowerCase().replaceAll(" ", "_");
      final doc = await _firestore.collection("subscriptions").doc(docId).get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data["plans"] != null) {
          final plansList = data["plans"] as List<dynamic>;
          _plans = plansList.map((p) => PlanModel.fromMap(p)).toList();
        }
        fetchPaymentModes();
        fetchNotificationAlerts();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching plans for $subscriptionName: $e");
      }
    }
    notifyListeners();
  }

  void selectPlan(String planString) {
    try {
      final plan = _plans.firstWhere((p) => p.toString() == planString);

      _selectedPlan = plan;
      _selectedBillingCycle = plan.billingCycle;
      _billingCycle = [plan.billingCycle];
    } catch (e) {
      if (kDebugMode) print("Plan not found for string: $planString");
    }
    notifyListeners();
  }

  void selectPayment(String selectedPaymentMode) {
    _selectedPayment = selectedPaymentMode;
    notifyListeners();
  }

  Future<void> selectDate(DateTime pickedDate) async {
    _selectedDate = pickedDate;
    notifyListeners();
  }

  void selectNotificaition(String selectedNotificationAlert) {
    _selectedNotification = selectedNotificationAlert;
  }

  Future<void> fetchActiveSubNumbers() async {
    final uid = _auth.currentUser!.uid;
    try {
      final snapshot =
          await _firestore
              .collection("users")
              .doc(uid)
              .collection("users_subscriptions")
              .get();
      _subCount = snapshot.docs.length;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Error counting subscriptions: $e");
    }
    notifyListeners();
  }

  bool success = false;
  bool isLoading = false;

  Future<bool> addSubscription({
    required BuildContext context,
    required String currentUserId,
    required String subscriptionName,
    required String paymentMode,
    required DateTime paymentDate,
    required String notificationAlert,
    required PlanModel plan,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final String subscriptionId = Uuid().v1();

      // Calculate next payment date
      DateTime? nextPaymentDate;
      if (plan.billingCycle == "Monthly") {
        nextPaymentDate = paymentDate.add(Duration(days: 30));
      } else if (plan.billingCycle == "Yearly") {
        nextPaymentDate = paymentDate.add(Duration(days: 365));
      }

      // Fetch icon URL from main subscription collection
      final snap =
          await _firestore
              .collection("subscriptions")
              .doc(subscriptionName.toLowerCase().replaceAll(" ", "_"))
              .get();
      final iconUrl = snap["iconUrl"];
      final webUrl = snap["website"];

      final subscription = SubscriptionModel(
        subscriptionId: subscriptionId,
        subscriptionName: subscriptionName,
        paymentMode: paymentMode,
        paymentDate: paymentDate,
        nextPaymentDate: nextPaymentDate!,
        notificationAlert: notificationAlert,
        plan: plan,
        iconUrl: iconUrl,
        webUrl: webUrl,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("users_subscriptions")
          .doc(subscriptionId)
          .set(subscription.toMap());
      success = true;
      if (context.mounted) {
        showSnack(
          text: "Subscription successfully added!",
          context: context,
          success: true,
        );
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        showSnack(text: e.message ?? "Something went wrong.", context: context);
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(text: e.toString(), context: context);
        return false;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return success;
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
