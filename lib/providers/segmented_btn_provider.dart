import 'package:flutter/material.dart';

class SegmentedBtnProvider extends ChangeNotifier {
  String _selected = "yourSubscriptions";

  String get selected => _selected;

  void select(String value) {
    _selected = value;
    notifyListeners();
  }
}
