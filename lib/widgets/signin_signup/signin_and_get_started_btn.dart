import 'package:flutter/material.dart';

class SignInAndGetStartedButton extends StatelessWidget {
  final Color buttonBgColor;
  final Color buttonFontColor;
  final void Function() onPressed;
  final bool fullWidth;
  final bool isLoading;
  final String buttonText;
  const SignInAndGetStartedButton({
    Key? key,
    this.isLoading = false,
    required this.buttonBgColor,
    required this.buttonFontColor,
    required this.onPressed,
    required this.fullWidth,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(3),
        backgroundColor: MaterialStateProperty.all(
          buttonBgColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        minimumSize: fullWidth
            ? MaterialStateProperty.all(
                const Size(double.infinity, 35),
              )
            : null,

        //now the button color will be same even if it is not focused.
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return buttonFontColor.withOpacity(0.2);
            }

            return buttonBgColor; //default color
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
