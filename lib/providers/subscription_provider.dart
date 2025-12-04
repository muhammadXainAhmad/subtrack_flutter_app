import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/methods/notification_methods.dart';
import 'package:subtrack/models/plan_model.dart';
import 'package:subtrack/models/subscription_model.dart';
import 'package:subtrack/providers/category_chart_provider.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:uuid/uuid.dart';

class SubscriptionProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _subscriptionNames = [];
  List<PlanModel> _plans = [];
  List<String> _billingCycle = [];
  List<String> _paymentModes = [];
  List<String> _notificationAlerts = [];
  String? _selectedSubscription;
  PlanModel? _selectedPlan;
  String? _selectedPaymentMode;
  String? _selectedBillingCycle;
  DateTime? _selectedDate;
  String? _selectedNotification;
  int? _subCount;
  double? _weeklyTotal;
  double? _monthlyTotal;
  double? _yearlyTotal;
  String _view = "Monthly";

  List<String> get subscriptionNames => _subscriptionNames;
  List<PlanModel> get plans => _plans;
  List<String> get billingCycle => _billingCycle;
  List<String> get paymentModes => _paymentModes;
  List<String> get notificationAlerts => _notificationAlerts;
  String? get selectedSubscription => _selectedSubscription;
  PlanModel? get selectedPlan => _selectedPlan;
  String? get selectedPaymentMode => _selectedPaymentMode;
  String? get selectedBillingCycle => _selectedBillingCycle;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedNotification => _selectedNotification;
  int? get subCount => _subCount;
  double? get weeklyTotal => _weeklyTotal;
  double? get monthlyTotal => _monthlyTotal;
  double? get yearlyTotal => _yearlyTotal;
  String get view => _view;

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
    _selectedPaymentMode = null;
    _selectedBillingCycle = null;
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
    _selectedPaymentMode = selectedPaymentMode;
    notifyListeners();
  }

  void selectNotification(String selectedNotificationAlert) {
    _selectedNotification = selectedNotificationAlert;
  }

  Future<void> calculateBills() async {
    _weeklyTotal = 0;
    _monthlyTotal = 0;
    _yearlyTotal = 0;
    final uid = _auth.currentUser!.uid;
    final subs =
        await _firestore
            .collection("users")
            .doc(uid)
            .collection("users_subscriptions")
            .get();
    for (var doc in subs.docs) {
      final data = doc.data();
      final cycle = data["plan"]["billingCycle"];
      final price = (data["plan"]["price"] as num).toDouble();

      if (cycle == "Monthly") {
        _weeklyTotal = (_weeklyTotal! + (price / 4.345)).roundToDouble();
        _monthlyTotal = (_monthlyTotal! + price).roundToDouble();
        _yearlyTotal = (_yearlyTotal! + (price * 12)).roundToDouble();
      }
      if (cycle == "Yearly") {
        _weeklyTotal = (_weeklyTotal! + (price / 52)).roundToDouble();
        _monthlyTotal = (_monthlyTotal! + (price / 12)).roundToDouble();
        _yearlyTotal = (_yearlyTotal! + price).roundToDouble();
      }
      notifyListeners();
    }
  }

  void setBillView(String view) {
    _view = view;
    notifyListeners();
  }

  // Fetch number of active subscriptions on home screen
  Future<void> fetchActiveSubNumbers() async {
    final uid = _auth.currentUser!.uid;
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("users_subscriptions")
          .snapshots()
          .listen((snapshot) {
            _subCount = snapshot.docs.length;
            notifyListeners();
          });
    } catch (e) {
      if (kDebugMode) print("Error counting subscriptions: $e");
    }
    notifyListeners();
  }

  // Adding a new subscription
  bool success = false;
  bool isLoading = false;

  NotificationMethods notificationMethods = NotificationMethods();

  Future<bool> addSubscription({
    required BuildContext context,
    required String currentUserId,
    required String subscriptionName,
    required String paymentMode,

    required String notificationAlert,
    required PlanModel plan,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final String subscriptionId = Uuid().v1();
      final DateTime paymentDate = DateTime.now();

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
      final category = snap["category"];
      final iconUrl = snap["iconUrl"];
      final webUrl = snap["website"];

      final subscription = SubscriptionModel(
        subscriptionId: subscriptionId,
        subscriptionName: subscriptionName,
        category: category,
        paymentMode: paymentMode,
        paymentDate: DateTime.now(),
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
      if (context.mounted) {
        showSnack(
          text: "Subscription successfully added!",
          context: context,
          success: true,
        );
        context.read<CategoryChartProvider>().fetchCategoryData();
      }
      final token = await notificationMethods.getDeviceToken();
      notificationMethods.sendPushNotification(
        deviceToken: token,
        title: "SubTrack",
        body: "Congrats! $subscriptionName Subscription Purchased!",
      );
      calculateBills();

      success = true;
      return success;
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

  // Loading data for existing subscription
  void loadEditSubscriptionData(SubscriptionModel editData) async {
    fetchPaymentModes();
    fetchNotificationAlerts();
    try {
      final docId = editData.subscriptionName.toLowerCase().replaceAll(
        " ",
        "_",
      );
      final doc = await _firestore.collection("subscriptions").doc(docId).get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data["plans"] != null) {
          final plansList = data["plans"] as List<dynamic>;
          _plans = plansList.map((p) => PlanModel.fromMap(p)).toList();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching plans for $editData.subscriptionName: $e");
      }
    }
    _selectedSubscription = editData.subscriptionName;
    _selectedPlan = editData.plan;
    _selectedPaymentMode = editData.paymentMode;
    _selectedBillingCycle = editData.plan.billingCycle;
    _selectedDate = editData.paymentDate;
    _selectedNotification = editData.notificationAlert;
    _billingCycle = [editData.plan.billingCycle];
    notifyListeners();
  }

  // Update existing subscription with new data
  Future<bool> updateSubscription({
    required BuildContext context,
    required String userId,
    required SubscriptionModel oldData,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final updated = SubscriptionModel(
        subscriptionId: oldData.subscriptionId,
        subscriptionName: oldData.subscriptionName,
        category: oldData.category,
        paymentDate: oldData.paymentDate,
        nextPaymentDate: oldData.nextPaymentDate,
        iconUrl: oldData.iconUrl,
        webUrl: oldData.webUrl,
        createdAt: oldData.createdAt,
        plan: _selectedPlan!,
        paymentMode: _selectedPaymentMode!,
        notificationAlert: _selectedNotification!,
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("users_subscriptions")
          .doc(oldData.subscriptionId)
          .update(updated.toMap());

      if (context.mounted) {
        showSnack(
          text: "Subscription successfully edited!",
          context: context,
          success: true,
        );
      }
      final token = await notificationMethods.getDeviceToken();
      notificationMethods.sendPushNotification(
        deviceToken: token,
        title: "SubTrack",
        body:
            "${oldData.subscriptionName} Subscription Updated!",
      );
      calculateBills();
      success = true;
      return success;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteSubscription({
    required BuildContext context,
    required subId,
    required String subName,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("users_subscriptions")
          .doc(subId)
          .delete();
      success = true;
      calculateBills();
      if (context.mounted) {
        context.read<CategoryChartProvider>().fetchCategoryData();
        showSnack(
          text: "Subscription successfully deleted!",
          context: context,
          success: true,
        );
      }
      final token = await notificationMethods.getDeviceToken();
      notificationMethods.sendPushNotification(
        deviceToken: token,
        title: "SubTrack",
        body: "$subName Subscription Deleted!",
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(text: e.message ?? "Something went wrong.", context: context);
        success = false;
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(text: e.toString(), context: context);
        success = false;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return success;
  }
}
