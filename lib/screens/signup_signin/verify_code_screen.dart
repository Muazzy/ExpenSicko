import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/signin_and_get_started_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyCode extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function() onPressed;
  final String phoneNumber;

  const VerifyCode({
    super.key,
    required this.textEditingController,
    required this.onPressed,
    required this.phoneNumber,
  });
  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<AuthRepository>().isLoading;

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
                color: AppColors.bodyTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter the 6-digit code that you recieved on your number $phoneNumber",
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppColors.bodyTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              // key: formKey,
              child: Pinput(
                controller: textEditingController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusPinTheme,
                errorPinTheme: errorPinTheme,
                errorText: 'Incorrect Pin',
                errorTextStyle: const TextStyle(
                  color: AppColors.darkPink,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                length: 6,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            const SizedBox(height: 24),
            SignInAndGetStartedButton(
              isLoading: isLoading,
              buttonText: 'Verify code',
              buttonBgColor: AppColors.darkPurple,
              buttonFontColor: AppColors.white,
              onPressed: onPressed,
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
      color: AppColors.darkPink,
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  textStyle: const TextStyle(
    color: AppColors.darkPink,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ),
);

PinTheme defaultPinTheme = PinTheme(
  width: 45,
  height: 55,
  decoration: BoxDecoration(
    border: Border.all(
      color: AppColors.darkPurple.withOpacity(0.5),
      width: 1,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  textStyle: const TextStyle(
    color: AppColors.darkPurple,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ),
);

PinTheme focusPinTheme = PinTheme(
  width: 45,
  height: 55,
  decoration: BoxDecoration(
    border: Border.all(
      color: AppColors.darkPurple,
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  textStyle: const TextStyle(
    color: AppColors.darkPurple,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  ),
);
