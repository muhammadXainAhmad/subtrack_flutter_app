import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:subtrack/utils/utils.dart';

class AuthenticationProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool success = false;

  Future<bool> createUserWithEmailPassword(
    String fullname,
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (fullname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showSnack(text: "Please fill all required fields.", context: context);
      return false;
    }
    if (password != confirmPassword) {
      showSnack(text: "Passwords do not match.", context: context);
      return false;
    }
    isLoading = true;
    notifyListeners();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      success = true;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(text: e.message ?? "Something went wrong.", context: context);
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(text: e.toString(), context: context);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return success;
  }

  Future<bool> loginUserWithEmailPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      showSnack(text: "Please fill all required fields.", context: context);
      return false;
    }
    isLoading = true;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      success = true;
    } on FirebaseAuthException catch (e) {
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

  Future<bool> googleSignIn(BuildContext context) async {
    const String webClientId =
        "451814373655-s3ugr590lff2jo443e71hs42kf6tpv5h.apps.googleusercontent.com";
    final GoogleSignIn signIn = GoogleSignIn.instance;
    isLoading = true;
    try {
      await signIn.initialize(serverClientId: webClientId);
      final GoogleSignInAccount account = await signIn.authenticate();
      GoogleSignInAuthentication googleAuth = account.authentication;
      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credentials);
      success = true;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(text: e.message ?? "Something went wrong.", context: context);
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(text: e.toString(), context: context);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return success;
  }

  Future<void> signOutUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth.signOut();
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnack(text: e.message ?? "Something went wrong.", context: context);
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(text: e.toString(), context: context);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
