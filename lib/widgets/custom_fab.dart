import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final void Function() onPressed;
  const CustomFAB({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: darkPurple,
      clipBehavior: Clip.hardEdge,
      // isExtended: t,
      onPressed: onPressed,
      child: Icon(
        Icons.add_rounded,
        color: white,
        size: MediaQuery.of(context).size.width * 0.1,
      ),
    );
  }
}
