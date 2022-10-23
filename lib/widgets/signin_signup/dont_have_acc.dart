import 'package:flutter/material.dart';

class DontHaveAnAcc extends StatelessWidget {
  final String leadingText;
  final String buttonText;
  final Color btnColor;
  final Color textColor;
  final void Function() onPressed;
  const DontHaveAnAcc({
    Key? key,
    required this.leadingText,
    required this.buttonText,
    required this.onPressed,
    required this.btnColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              leadingText,
              style: TextStyle(
                color: textColor.withOpacity(0.3),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor:
                    MaterialStateProperty.all(btnColor.withOpacity(0.1)),
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: btnColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  height: 1,
                  decorationColor: btnColor,
                  decorationThickness: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
