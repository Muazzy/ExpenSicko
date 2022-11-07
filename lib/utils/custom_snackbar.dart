import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: darkPurple,
      content: Text(
        text,
        style: const TextStyle(color: white),
      ),
    ),
  );
}
