import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChartProvider extends ChangeNotifier {
  final List<Color> pieChartSectionColors = [
    Color(0xFF113CCF),
    Color(0xFF1DB954),
    Color(0xFFF25022),
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.pink,
  ];

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Map<String, double> categoryPrices = {};
  Map<String, int> categoryCounts = {};
  Set<String> uniqueCategories = {};

  bool isLoading = false;

  Future<void> fetchCategoryData() async {
    isLoading = true;
    notifyListeners();

    categoryPrices = {};
    categoryCounts = {};
    uniqueCategories = {};

    final allSubs =
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("users_subscriptions")
            .get();

    List<String> categories =
        allSubs.docs.map((doc) => doc["category"].toString()).toList();

    uniqueCategories = categories.toSet();

    for (var doc in allSubs.docs) {
      String cat = doc["category"];
      categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1;

      double price = (doc["plan"]["price"] as num).toDouble();
      if (doc["plan"]["billingCycle"] == "Yearly") {
        price = price / 12;
      }

      categoryPrices[cat] = (categoryPrices[cat] ?? 0) + price;
    }

    isLoading = false;
    notifyListeners();
  }
}
