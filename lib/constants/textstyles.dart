import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:flutter/material.dart';

final TextStyle kExpenseBodyTextStyle = TextStyle(
  color: Colors.deepPurple.shade900,
  fontWeight: FontWeight.w600,
  shadows: const [
    Shadow(
      offset: Offset(1.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromRGBO(0, 0, 0, 0.2),
    ),
  ],
);

const TextStyle kExpenseHeadingTextStyle = TextStyle(
  color: darkPurple,
  fontWeight: FontWeight.w600,
  shadows: [
    Shadow(
      offset: Offset(1.0, 1.5),
      blurRadius: 3.0,
      color: Color.fromRGBO(255, 255, 255, 0.3),
      // color: Colors.grey,
    ),
  ],
);

const TextStyle kTitleTextStyle = TextStyle(
  color: bodyTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 14,
);

final TextStyle kSubtitleTextStyle = TextStyle(
  color: bodyTextColor.withOpacity(0.4),
  fontSize: 11,
);
