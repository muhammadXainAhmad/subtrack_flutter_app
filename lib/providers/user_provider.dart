import 'package:flutter/foundation.dart';
import 'package:subtrack/methods/firestore_methods.dart';
import 'package:subtrack/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await FirestoreMethods().getUserData();
    _user = user;
    notifyListeners();
  }
}
