// import 'package:expense_tracker_v2/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
//       .whenComplete(() => print('Done'));
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Expense Tracker',
//       theme: ThemeData(
//         // primarySwatch: Colors.blue,
//         primaryColor: Colors.grey,
//         scaffoldBackgroundColor: Colors.green,
//       ),
//       home: Root(),
//     );
//   }
// }

// class Root extends StatefulWidget {
//   Root({Key? key}) : super(key: key);

//   @override
//   State<Root> createState() => _RootState();
// }

// class _RootState extends State<Root> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Let's Start Coding!"),
//       ),
//     );
//   }
// }

import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/model/auth_repository.dart';
import 'package:expense_tracker_v2/screens/number_signin_screen.dart';
import 'package:expense_tracker_v2/screens/onboard_screen.dart';
import 'package:expense_tracker_v2/screens/root_screen.dart';
import 'package:expense_tracker_v2/screens/signin_screen.dart';
import 'package:expense_tracker_v2/screens/signup_screen.dart';
import 'package:expense_tracker_v2/screens/verify_code_screen.dart';
import 'package:expense_tracker_v2/views/home.dart';
// import 'package:expense_tracker_v2/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   //the scroll overflow color is this one. (secondary)
        //   secondary: darkPurple.withOpacity(0.1),
        // ),
        primarySwatch: materialDarkPurple,
      ),
      home: StreamBuilder<bool>(
        initialData: false,
        stream: authSteam,
        builder: (context, snapshot) {
          final signedIn = snapshot.data ?? false;
          // final siginingIn = snapshot.connectionState.name;
          // print(siginingIn);
          // return signedIn
          //     ? Center(child: CircularProgressIndicator())
          //     : LoginWidget();

          return signedIn ? HomeWidget() : const RootScreen();
        },
      ),
      routes: {
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/numberSignIn': (context) => const SignInWithNumber(),
        '/verifyCode': (context) => const VerifyCode(),
        '/rootScreen': (context) => const RootScreen(),
      },
    ),
  );
}
