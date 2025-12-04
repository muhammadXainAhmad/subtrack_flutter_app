import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subtrack/models/user_model.dart';

class FirestoreMethods {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserData() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }
}
