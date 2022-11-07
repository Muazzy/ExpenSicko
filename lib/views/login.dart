// import 'package:expense_tracker_v2/model/auth_repository.dart';
// import 'package:flutter/material.dart';

// class LoginWidget extends StatefulWidget {
//   @override
//   State<LoginWidget> createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   String phoneNumber = '';
//   @override
//   Widget build(BuildContext context) {
//     GlobalKey<FormState> formKey = GlobalKey<FormState>();
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'You need to be signed in to use this application',
//                 textAlign: TextAlign.center,
//                 textScaleFactor: 1.5,
//               ),
//             ),
//             TextButton.icon(
//               // onPressed: () {
//               //   signIn();

//               // CircularProgressIndicator();
//               // },
//               onPressed: signInWithGoogle,
//               icon: Icon(Icons.person),
//               label: Text('GOOGLE SIGN IN'),
//             ),
//             Spacer(),
//             Form(
//               key: formKey,
//               child: TextFormField(
//                 onChanged: (v) {
//                   phoneNumber = v;
//                 },
//                 validator: (v) {
//                   if (v!.length < 11) return 'incorrect format';
//                   return null;
//                 },
//               ),
//             ),
//             TextButton.icon(
//               // onPressed: formKey.currentState?.validate() ?? false
//               //     ? () {
//               //         print('Succefull');
//               //       }
//               //     // : () {
//               //     //     print('wasted');
//               //     //   },
//               //     : null,
//               onPressed: () {
//                 if (formKey.currentState!.validate()) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Processing Data Succesfully.'),
//                     ),
//                   );
//                   print('successful');
//                 } else {
//                   print('!successful');
//                 }
//               },
//               icon: Icon(Icons.person),
//               label: Text('phone number signin'.toUpperCase()),
//             ),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
