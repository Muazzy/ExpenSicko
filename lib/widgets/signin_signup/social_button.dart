import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final Color iconColor;
  final IconData buttonIcon;
  final void Function() onPressed;

  const SocialButton(
      {Key? key,
      required this.iconColor,
      required this.buttonIcon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 13,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Icon(
        buttonIcon,
        color: iconColor,
      ),
    );
  }
}
