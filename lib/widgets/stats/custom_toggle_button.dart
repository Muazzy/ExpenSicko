import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({
    Key? key,
    required this.onPressed,
    required this.isExpense,
    required this.width,
    required this.padding,
    required this.btnText,
  }) : super(key: key);

  final void Function() onPressed;
  final bool isExpense;
  final double width;
  final double padding;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: isExpense
            ? MaterialStateProperty.all(3)
            : MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          isExpense ? darkPurple : const Color(0xffF8F8F8),
          // 0xfffefdff
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: isExpense
                ? BorderRadius.circular(10)
                // : const BorderRadius.only(
                //     topLeft: Radius.circular(10),
                //     bottomLeft: Radius.circular(10),
                //   ),
                : BorderRadius.circular(10),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(width * 0.5 - padding, width * 0.12),
        ),
        //now the button color will be same even if it is not focused.
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return darkPurple.withOpacity(0.2);
            }

            return darkPurple; //default color
          },
        ),
      ),
      child: Text(
        btnText,
        style: TextStyle(
          color: isExpense ? white : bodyTextColor.withOpacity(0.5),
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
