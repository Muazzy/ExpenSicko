import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/signin_and_get_started_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class VerifyCode extends StatefulWidget {
  // final String phoneNumber;
  const VerifyCode({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String verificationCode =
        '696969'; //here will be the original verification code.
    final phoneNumber = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              flex: 2,
              child: SvgPicture.asset('assets/phone.svg'),
            ),
            const Spacer(),
            const Text(
              "Enter the Code ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: bodyTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter the 6-digit code that you recieved on your number $phoneNumber",
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: bodyTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusPinTheme,
                errorPinTheme: errorPinTheme,
                errorText: 'Incorrect Pin',
                errorTextStyle: const TextStyle(
                  color: darkPink,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                length: 6,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                validator: (pin) {
                  return pin == verificationCode ? null : 'Pin is incorrect';
                },
              ),
            ),
            const SizedBox(height: 24),
            SignInAndGetStartedButton(
              buttonText: 'Verify code',
              buttonBgColor: darkPurple,
              buttonFontColor: white,
              onPressed: () {
                //actual loging/signing in functionality.
                if (formKey.currentState!.validate()) {
                  print('logging in');
                }
              },
              fullWidth: true,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

PinTheme errorPinTheme = PinTheme(
  width: 45,
  height: 55,
  decoration: BoxDecoration(
    border: Border.all(
      color: darkPink,
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  textStyle: const TextStyle(
    color: darkPink,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ),
);

PinTheme defaultPinTheme = PinTheme(
  width: 45,
  height: 55,
  decoration: BoxDecoration(
    border: Border.all(
      color: darkPurple.withOpacity(0.5),
      width: 1,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  textStyle: const TextStyle(
    color: darkPurple,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ),
);

PinTheme focusPinTheme = PinTheme(
  width: 45,
  height: 55,
  decoration: BoxDecoration(
    border: Border.all(
      color: darkPurple,
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  textStyle: const TextStyle(
    color: darkPurple,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ),
);
