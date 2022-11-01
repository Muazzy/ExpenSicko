import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.categoryName,
    // required this.categoryAmount,
    required this.categoryColor,
    required this.borderWidth,
  }) : super(key: key);

  final String categoryName;
  final double borderWidth;
  // final String categoryAmount; //this can be added later as a percentage.
  final Color categoryColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: categoryColor, width: borderWidth),
            ),
          ),
          Text(
            categoryName,
            style: TextStyle(
              color: categoryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
