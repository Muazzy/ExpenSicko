import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/res/content.dart';
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
      heroTag: fabHeroTag,
      elevation: 0,
      backgroundColor: AppColors.darkPurple,
      clipBehavior: Clip.hardEdge,
      // isExtended: t,
      onPressed: onPressed,
      child: Icon(
        Icons.add_rounded,
        color: AppColors.white,
        size: MediaQuery.of(context).size.width * 0.1,
      ),
    );
  }
}
