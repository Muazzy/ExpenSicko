// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// // import 'dart:js';

// import 'package:expense_tracker_v2/widgets/signin_signup/dont_have_acc.dart';
// import 'package:expense_tracker_v2/widgets/signin_signup/signin_and_get_started_btn.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; //for input formatters

// // import 'package:stich_and_sew/constants/content.dart';
// // import 'package:stich_and_sew/widgets/signin_signup/dont_have_acc.dart';
// // import 'package:stich_and_sew/widgets/signin_signup/signin_and_get_started_btn.dart';

// class OtpDialog extends StatefulWidget {
//   final Color submitButtonColor;
//   final Color submitButtonFontColor;
//   final void Function() onSubmit;

//   //add a form controller here later.

//   final Color cancelAndResendButtonColor;

//   final void Function() onCancel;
//   final void Function() onResendCode;
//   // final Color resendCodeButtonColor;

//   const OtpDialog({
//     Key? key,
//     required this.submitButtonColor,
//     required this.submitButtonFontColor,
//     required this.onSubmit,
//     // required this.cancelButtonColor,
//     required this.onCancel,
//     required this.onResendCode,
//     required this.cancelAndResendButtonColor,
//     // required this.resendCodeButtonColor,
//   }) : super(key: key);

//   @override
//   State<OtpDialog> createState() => _OtpDialogState();
// }

// class _OtpDialogState extends State<OtpDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment
//           .center, //so that the alert is shown at the center of the screen.
//       mainAxisSize: MainAxisSize
//           .min, //so that the card only takes the required space and not more than that
//       children: [
//         AlertDialog(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           alignment: Alignment.center,
//           titlePadding: EdgeInsets.all(0),
//           contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//           actionsAlignment: MainAxisAlignment.center,
//           actionsPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 onPressed: widget.onCancel,
//                 icon: Icon(
//                   Icons.cancel_sharp,
//                   color: widget.cancelAndResendButtonColor.withOpacity(0.5),
//                 ),
//               )
//             ],
//           ),
//           content: Column(
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 verificationCode,
//                 textAlign: TextAlign.center,
//                 // style: TextStyle(
//                 //   fontSize: 24.0,
//                 //   fontWeight: FontWeight.w600,
//                 // ),
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 widget.isEmailVerification
//                     ? verficationCodeBodyEmail
//                     : verficationCodeBodyPhoneNumber,
//                 textAlign: TextAlign.center,
//                 // style: TextStyle(
//                 //   fontSize: 16.0,
//                 //   fontWeight: FontWeight.w400,
//                 // ),
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               SizedBox(height: 24),
//               Form(
//                 //this will prevent the user from closing the popup with back button
//                 onWillPop: () async => false,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(width: 10,),
//                     PinField(
//                       pinFieldColor: widget.submitButtonColor,
//                     ),
//                     PinField(
//                       pinFieldColor: widget.submitButtonColor,
//                     ),
//                     PinField(
//                       pinFieldColor: widget.submitButtonColor,
//                     ),
//                     PinField(
//                       pinFieldColor: widget.submitButtonColor,
//                     ),
//                     SizedBox(width: 10,),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             //continue/submit button
//             Center(
//               child: SignInAndGetStartedButton(
//                 buttonText: 'Continue',
//                 buttonBgColor: widget.submitButtonColor,
//                 buttonFontColor: widget.submitButtonFontColor,
//                 onPressed: widget.onSubmit,
//                 fullWidth: false,
//               ),
//             ),
//             //resend code button
//             DontHaveAnAcc(
//               leadingText: '',
//               buttonText: 'Resend code',
//               onPressed: widget.onResendCode,
//               btnColor: widget.cancelAndResendButtonColor.withOpacity(0.5),
//               textColor: Colors.white,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

// class PinField extends StatelessWidget {
//   const PinField({
//     Key? key,
//     required this.pinFieldColor,
//   }) : super(key: key);

//   // final OtpDialog widget;
//   final Color pinFieldColor;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 50,
//       height: 60,
//       child: TextFormField(
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//         ),
//         onSaved: ((newValue) {
//           //save the value here for verification of the pin
//         }),
//         onChanged: ((value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus();
//           }
//         }),
//         // style: TextStyle(
//         //   color: pinFieldColor,
//         //   fontSize: 16.0,
//         //   fontWeight: FontWeight.w600,
//         // ),
//         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//               color: pinFieldColor,
//             ),
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         // maxLength: 1,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//       ),
//     );
//   }
// }



// // class OtpDialog extends StatefulWidget {
// //   final Color textColor;
// //   final Color popupBgColor;
// //   final void Function() onCancel;
// //   final Color cancelButtonColor;

// //   const OtpDialog({
// //     Key? key,
// //     required this.textColor,
// //     required this.popupBgColor,
// //     required this.onCancel,
// //     required this.cancelButtonColor,
// //   }) : super(key: key);

// //   @override
// //   State<OtpDialog> createState() => _OtpDialogState();
// // }

// // class _OtpDialogState extends State<OtpDialog> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Material(
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             mainAxisAlignment:
// //                 MainAxisAlignment.center, //for centering the dialog.
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.end,
// //                 children: [
// //                   IconButton(
// //                     onPressed: widget.onCancel,
// //                     icon: Icon(
// //                       Icons.cancel_sharp,
// //                       color: widget.cancelButtonColor,
// //                     ),
// //                   )
// //                 ],
// //               ),
// //               Text(''),
// //               SizedBox(height: 16),
// //               Form(
// //                 onWillPop: () async => false,
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     PinField(widget: widget),
// //                     PinField(widget: widget),
// //                     PinField(widget: widget),
// //                     PinField(widget: widget),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
