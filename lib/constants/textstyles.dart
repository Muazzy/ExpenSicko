import 'package:flutter/material.dart';

const TextStyle kExpenseBodyTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  shadows: [
    Shadow(
      offset: Offset(1.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromRGBO(0, 0, 0, 0.2),
    ),
  ],
);

const TextStyle kExpenseHeadingTextStyle = TextStyle(
  color: Colors.white70,
  fontWeight: FontWeight.w600,
  shadows: [
    Shadow(
      offset: Offset(1.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromRGBO(0, 0, 0, 0.5),
    ),
  ],
);
