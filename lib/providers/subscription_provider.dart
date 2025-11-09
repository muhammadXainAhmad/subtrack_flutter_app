import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:subtrack/models/plan_model.dart';

class SubscriptionProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _subscriptionNames = [];
  List<PlanModel> _plans = [];
  List<String> _billingCycle = [];
  String? _selectedSubscription;
  PlanModel? _selectedPlan;
  String? _selectedBillingCycle;
  DateTime? _selectedDate;

  List<String> get subscriptionNames => _subscriptionNames;
  List<PlanModel> get plans => _plans;
  List<String> get billingCycle => _billingCycle;
  String? get selectedSubscription => _selectedSubscription;
  PlanModel? get selectedPlan => _selectedPlan;
  String? get selectedBillingCycle => _selectedBillingCycle;
  DateTime? get selectedDate => _selectedDate;

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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      notifyListeners();
    }
  }
}
