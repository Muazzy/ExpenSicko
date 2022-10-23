// import 'package:flutter/material.dart';

// class PasswordChangedDialog extends StatelessWidget {
//   final Color titleAndButtonColor;
//   final Color buttonFontColor;
//   final void Function() onPressed;

//   const PasswordChangedDialog({
//     Key? key,
//     required this.titleAndButtonColor,
//     required this.buttonFontColor,
//     required this.onPressed,
//   }) : super(key: key);

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
//           // insetPadding: const EdgeInsets.all(8),
//           titlePadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           actionsAlignment: MainAxisAlignment.center,
//           actionsPadding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//           title: Icon(
//             // FontAwesomeIcons.circleCheck,
//             Icons.check,
//             size: 72,
//             color: titleAndButtonColor,
//           ),
//           content: Column(
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 passwordChanged,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               const SizedBox(height: 24.0),
//               Text(
//                 passwordChangedBodyText,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodyText1,
//               ),
//             ],
//           ),
//           actions: [
//             SignInAndGetStartedButton(
//               buttonText: 'Done',
//               buttonBgColor: titleAndButtonColor,
//               buttonFontColor: buttonFontColor,
//               onPressed: onPressed,
//               fullWidth: false,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
