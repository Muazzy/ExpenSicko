import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/signin_and_get_started_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class SignInWithNumber extends StatefulWidget {
  const SignInWithNumber({Key? key}) : super(key: key);

  @override
  State<SignInWithNumber> createState() => _SignInWithNumberState();
}

class _SignInWithNumberState extends State<SignInWithNumber> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String completeNumber = '';
  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<AuthRepository>().isLoading;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                flex: 2,
                child: SvgPicture.asset('assets/phone.svg'),
              ),
              const Spacer(),
              const Text(
                "Phone Verification",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.bodyTextColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "We need to register your phone before getting started!",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  color: AppColors.bodyTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              IntlPhoneField(
                // so that the user could not input zero 0 as a first character.
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]'),
                  ),
                  FilteringTextInputFormatter.deny(
                    RegExp(r'^0+'), //users can't type 0 at 1st position
                  ),
                ],
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 14, height: 0),
                flagsButtonMargin: const EdgeInsets.only(right: 0, left: 4),
                flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 4),
                showDropdownIcon: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: AppColors.darkPurple,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 1),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.darkPurple,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: '3xxxxxxxxxx',
                  hintStyle: TextStyle(
                    height: 0,
                    fontSize: 14,
                  ),
                ),
                initialCountryCode: 'PK',
                onChanged: (phone) {
                  setState(() {
                    completeNumber = phone.completeNumber;
                  });
                },
                textAlignVertical: TextAlignVertical.center,
              ),
              const SizedBox(height: 24),
              SignInAndGetStartedButton(
                isLoading: isLoading,
                buttonText: 'Send the code',
                buttonBgColor: AppColors.darkPurple,
                buttonFontColor: AppColors.white,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    context
                        .read<AuthRepository>()
                        .phoneSignIn(context, completeNumber);
                  }
                },
                fullWidth: true,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
