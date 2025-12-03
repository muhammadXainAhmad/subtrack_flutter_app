import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExploreProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _subscriptions = [];

  List<Map<String, dynamic>> _filteredSubs = [];
  List<Map<String, dynamic>> get filteredSubs => _filteredSubs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ExploreProvider() {
    fetchSubscriptions();
  }

  void clearSearch() {
    _filteredSubs = _subscriptions;
    notifyListeners();
  }

  Future<void> fetchSubscriptions() async {
    _isLoading = true;
    notifyListeners();
    final snapshot =
        await _firestore
            .collection("subscriptions")
            .orderBy("name", descending: false)
            .get();

    _subscriptions = snapshot.docs.map((doc) => doc.data()).toList();
    _filteredSubs = _subscriptions;
    _isLoading = false;
    notifyListeners();
  }

  void filterSearch(String search) {
    if (search.isEmpty) {
      _filteredSubs = _subscriptions;
    } else {
      _filteredSubs =
          _subscriptions.where((sub) {
            final name = sub["name"].toString().toLowerCase();
            final desc = sub["description"].toString().toLowerCase();
            return name.contains(search.toLowerCase()) ||
                desc.contains(search.toLowerCase());
          }).toList();
    }
    notifyListeners();
  }
}
