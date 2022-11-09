import 'package:expense_tracker_v2/screens/verify_code_screen.dart';
import 'package:expense_tracker_v2/utils/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends ChangeNotifier {
  final FirebaseAuth _auth;
  AuthRepository(this._auth);

  bool isLoading = false;

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  static String get currentUserUid =>
      FirebaseAuth.instance.currentUser?.uid ?? '';

  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  // Stream<bool> get authState =>
  //     _auth.authStateChanges().map((user) => user != null);
  Stream<User?> get authState => _auth.authStateChanges();

  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      FocusScope.of(context).unfocus();

      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await newUser.user?.updateDisplayName(name).whenComplete(
        () {
          isLoading = false;
          notifyListeners();
          if (currentUserUid.isNotEmpty) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/rootScreen',
              (route) => false,
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the firebase error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      FocusScope.of(context).unfocus();

      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .whenComplete(
        () {
          isLoading = false;
          notifyListeners();
          if (currentUserUid.isNotEmpty) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/rootScreen',
              (route) => false,
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      FocusScope.of(context).unfocus();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _auth.signInWithCredential(credential).whenComplete(
          () {
            isLoading = false;
            notifyListeners();
            if (currentUserUid.isNotEmpty) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/rootScreen',
                (route) => false,
              );
            }
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController =
        TextEditingController(); // FOR ANDROID, IOS
    isLoading = true;
    notifyListeners();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      //  Automatic handling of the SMS code
      verificationCompleted: (PhoneAuthCredential credential) async {
        // !!! works only on android !!!
        // await _auth.signInWithCredential(credential);
        // Navigator.pushNamed(context, '/rootScreen');
      },
      // Displays a message when verification fails
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      // Displays the verification screen when OTP is sent
      codeSent: ((String verificationId, int? resendToken) async {
        isLoading = false;
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyCode(
              textEditingController: codeController,
              onPressed: () async {
                isLoading = true;
                notifyListeners();
                FocusScope.of(context).unfocus();

                print(codeController.text.trim());
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeController.text.trim(),
                );

                //now signIn with the credentials

                await _auth.signInWithCredential(credential).whenComplete(
                  () async {
                    isLoading = false;
                    notifyListeners();
                    if (currentUserUid.isNotEmpty) {
                      showSnackBar(context, 'Signing in');
                      await Future.delayed(
                        const Duration(milliseconds: 200),
                        () => Navigator.pushNamedAndRemoveUntil(
                            context, '/rootScreen', (route) => false),
                      );
                    }
                  },
                );
              },
              phoneNumber: phoneNumber,
            ),
          ),
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      timeout: const Duration(seconds: 5),
    );
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut().whenComplete(
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/signIn',
              (route) => false,
            ),
            // () => AuthRepository.materialNavigatorKey.currentState!.popUntil(
            //   (route) => route.isFirst,
            // ),
          );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}
