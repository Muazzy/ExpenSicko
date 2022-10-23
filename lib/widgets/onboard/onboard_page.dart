import 'package:flutter/material.dart';

class OnboardPage extends StatelessWidget {
  final String image;
  final String heading;
  final String bodyText;
  final Color textColor;
  const OnboardPage(
      {Key? key,
      required this.image,
      required this.heading,
      required this.bodyText,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.085,
      ),
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 3,
            child: Image.asset(image),
          ),
          const Spacer(),
          Text(
            heading,
            textAlign: TextAlign.center,

            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
            // style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            bodyText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            // style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //       color: textColor,
            //     ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
