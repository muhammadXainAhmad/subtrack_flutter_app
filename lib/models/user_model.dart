import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;

  UserModel({required this.uid, required this.email, required this.fullName});

  Map<String, dynamic> toMap() => {
    "uid": uid,
    "fullName": fullName,
    "email": email,
  };
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot["uid"],
      fullName: snapshot["fullName"],
      email: snapshot["email"],
    );
  }
}
