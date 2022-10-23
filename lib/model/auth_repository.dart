import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth = FirebaseAuth.instance;
// init() {}

String get currentUid => _auth.currentUser?.uid ?? '';

Stream<bool> get authSteam =>
    _auth.authStateChanges().map((user) => user != null);

Future<void> signOut() => _auth.signOut();

// works for web only
// Future<UserCredential> signIn() {
//   final googleProvider = GoogleAuthProvider();
//   return _auth.signInWithPopup(googleProvider);
// }

Future<UserCredential?> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  return await signIn(credential);
}

Future<UserCredential?> signIn(credentials) async {
  try {
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credentials).catchError(
          (error) => print(error),
        );
  } on PlatformException catch (e) {
    if (e.message == 'sign_in_canceled') {
      print(e.toString());
    } else {
      rethrow;
    }

    // print();
    return null;
  }
}

verifyPhoneNumber(String phoneNumber, onVerificationCompleted, onCodeSent,
    onVerificationFailed) async {
  _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    // verificationCompleted: (PhoneAuthCredential credential) {},
    verificationCompleted: onVerificationCompleted,
    // verificationFailed: (FirebaseAuthException e) {},
    verificationFailed: onVerificationFailed,
    // codeSent: (String verificationId, int? resendToken) {},
    codeSent: onCodeSent,
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
