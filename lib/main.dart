import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/firebase_options.dart';
import 'package:expense_tracker_v2/screens/user_profile.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/screens/add_transaction_screen.dart';
import 'package:expense_tracker_v2/screens/number_signin_screen.dart';
import 'package:expense_tracker_v2/screens/onboard_screen.dart';
import 'package:expense_tracker_v2/screens/root_screen.dart';
import 'package:expense_tracker_v2/screens/signin_screen.dart';
import 'package:expense_tracker_v2/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'services/data_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DataRepositroy>(
          lazy: false,
          create: (context) => DataRepositroy(FirebaseFirestore.instance),
        ),
        ChangeNotifierProvider<AuthRepository>(
          create: (context) => AuthRepository(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthRepository>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: materialDarkPurple,
          textTheme: GoogleFonts.interTextTheme(),
        ),
        home: const AuthWrapper(),
        routes: {
          '/signIn': (context) => const SignInScreen(),
          '/signUp': (context) => const SignUpScreen(),
          '/numberSignIn': (context) => const SignInWithNumber(),
          '/rootScreen': (context) => const RootScreen(),
          '/addTransaction': (context) => AddTransaction(),
          '/userProfile': (context) => UserProfile()
        },
      ),
    ),
  );
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      initialData: null,
      stream: context.watch<AuthRepository>().authState,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const RootScreen();
        } else if (snapshot.hasError) {
          return const ScaffoldMessenger(
            child: SnackBar(
              content: Text('Something went wrong'),
            ),
          );
        } else {
          return const OnBoardScreen();
        }
      },
    );
  }
}
