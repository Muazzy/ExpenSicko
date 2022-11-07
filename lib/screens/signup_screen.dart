import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/model/auth_repository.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/custom_textfield.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/dont_have_acc.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/signin_and_get_started_btn.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/social_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();
    bool isLoading = context.watch<AuthRepository>().isLoading;

    return Scaffold(
      resizeToAvoidBottomInset: true, //to make the textFormFields in view
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: bodyTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: bodyTextColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    //TODO implement this functionality to get name of the user.
                    // CustomFormField(
                    //   labelText: 'Name',
                    //   isPassword: false,

                    //   primaryColor: darkPurple,
                    //   textColor: bodyTextColor,
                    // ),
                    const SizedBox(height: 24),
                    CustomFormField(
                      labelText: 'Email',
                      isPassword: false,
                      textEditingController: emailController,
                      primaryColor: darkPurple,
                      textColor: bodyTextColor,
                    ),
                    const SizedBox(height: 24),
                    CustomFormField(
                      labelText: 'Password',
                      isPassword: true,
                      textEditingController: passwordController,
                      primaryColor: darkPurple,
                      textColor: bodyTextColor,
                    ),
                    const SizedBox(height: 24),
                    SignInAndGetStartedButton(
                      fullWidth: true,
                      buttonText: 'Sign Up',
                      buttonBgColor: darkPurple,
                      buttonFontColor: Colors.white,
                      onPressed: () {
                        context.read<AuthRepository>().signUpWithEmail(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context,
                            );
                      },
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'or with',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: bodyTextColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialButton(
                          iconColor: darkPurple,
                          buttonIcon: FontAwesomeIcons.phone,
                          onPressed: () {
                            Navigator.pushNamed(context, '/numberSignIn');
                          },
                        ),
                        SocialButton(
                          iconColor: darkPink,
                          buttonIcon: FontAwesomeIcons.google,
                          onPressed: () {
                            context
                                .read<AuthRepository>()
                                .signInWithGoogle(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DontHaveAnAcc(
                      leadingText: "Already have an account? ",
                      buttonText: 'Sign In',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      btnColor: darkPurple,
                      textColor: bodyTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
