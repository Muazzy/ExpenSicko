import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/signin_and_get_started_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInWithNumber extends StatefulWidget {
  const SignInWithNumber({Key? key}) : super(key: key);

  @override
  State<SignInWithNumber> createState() => _SignInWithNumberState();
}

class _SignInWithNumberState extends State<SignInWithNumber> {
  final TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String completeNumber = '';
  @override
  Widget build(BuildContext context) {
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
                    color: bodyTextColor),
              ),
              const SizedBox(height: 10),
              const Text(
                "We need to register your phone before getting started!",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  color: bodyTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              IntlPhoneField(
                style: const TextStyle(fontSize: 14, height: 0),
                flagsButtonMargin: const EdgeInsets.only(right: 0, left: 4),
                flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 4),
                showDropdownIcon: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: darkPurple,
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
                      color: darkPurple,
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
                buttonText: 'Send the code',
                buttonBgColor: darkPurple,
                buttonFontColor: white,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print(completeNumber);
                    Navigator.pushNamed(
                      context,
                      '/verifyCode',
                      arguments: completeNumber,
                    );
                    // Navigator
                    //signup/signin function here
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
