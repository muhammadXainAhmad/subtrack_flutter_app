import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:subtrack/screens/otp_screen.dart';
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

  Future<bool> sendPasswordResetEmail(
    BuildContext context,
    String email,
  ) async {
    if (email.isEmpty) {
      showSnack(text: "Please enter your email address.", context: context);
      return false;
    }
    isLoading = true;
    notifyListeners();
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        showSnack(
          text: "Password reset email sent.",
          context: context,
          success: true,
        );
      }
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

  Future<bool> signInPhone(BuildContext context, String phoneNumber) async {
    isLoading = true;
    notifyListeners();
    if (phoneNumber.isEmpty) {
      showSnack(text: "Please enter your phone number.", context: context);
      isLoading = false;
      notifyListeners();
      return false;
    }
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
          if (context.mounted) {
            showSnack(
              text: "Phone automatically verified!",
              context: context,
              success: true,
            );
            Navigator.pop(context);
          }
        },
        verificationFailed: (error) {
          showSnack(text: error.message!, context: context);
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => OtpScreen(
                        verificationId: verificationId,
                        phoneNumber: phoneNumber,
                      ),
                ),
              );
            }
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
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

  String? _verificationId;
  Future<void> sendOtp({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed: (error) {
        showSnack(
          text: error.message ?? "Error sending code",
          context: context,
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        showSnack(text: "Code sent successfully", context: context);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
    isLoading = false;
    notifyListeners();
  }

  // Verify OTP
  Future<void> verifyOtp({
    required String otp,
    required BuildContext context,
  }) async {
    if (_verificationId == null) {
      showSnack(text: "Verification ID missing", context: context);
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (context.mounted) {
        showSnack(text: "Invalid code. Try again.", context: context);
      }
    }
  }

  Future<void> resendOtp({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    await sendOtp(phoneNumber: phoneNumber, context: context);
  }

  Future<void> signOutUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth.signOut();
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
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
