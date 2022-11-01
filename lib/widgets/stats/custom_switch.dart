import 'package:expense_tracker_v2/widgets/stats/custom_toggle_button.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    Key? key,
    required this.width,
    required this.padding,
    required this.isExpense,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final double padding;
  final bool isExpense;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomToggleButton(
          btnText: 'Income',
          onPressed: onPressed,
          isExpense: !isExpense,
          width: width,
          padding: padding,
        ),
        CustomToggleButton(
          btnText: 'Expense',
          onPressed: onPressed,
          isExpense: isExpense,
          width: width,
          padding: padding,
        ),
      ],
    );
  }
}
