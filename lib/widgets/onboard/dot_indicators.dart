import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final Color activeColor;
  final Color notActiveColor;

  final int index;
  final int currentIndex;
  const DotIndicator({
    Key? key,
    required this.activeColor,
    required this.notActiveColor,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: currentIndex == index ? 16 : 8,
      width: currentIndex == index ? 16 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentIndex == index ? activeColor : notActiveColor,
      ),
    );
  }
}
