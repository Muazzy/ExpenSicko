// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.075),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [UserTile(), const SizedBox(height: 24), BalanceCard()],
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height:
      // MediaQuery.of(context).size.width * .55, //this wont be needed
      // width: MediaQuery.of(context).size.width * .85,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: darkPurple,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(-0.8, -0.8),
          stops: [0.0, 0.5, 0.5, 1],
          colors: [
            darkPurple.withOpacity(1),
            darkPurple.withOpacity(1),
            darkPurple.withOpacity(0.9),
            darkPurple.withOpacity(0.95),
          ],
          tileMode: TileMode.repeated,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Balance'.toUpperCase(),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.3,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '10043.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: 'PKR',
                    style: TextStyle(
                      color: darkPink,
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                      ],
                      letterSpacing: 1,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: bgPurplenew,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: darkPink.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.green.shade900,
                            ),
                            Text(
                              'Income',
                              // style: TextStyle(
                              //   color: Colors.white70,
                              //   fontWeight: FontWeight.w600,
                              //   shadows: [
                              //     Shadow(
                              //       offset: Offset(1.0, 1.0),
                              //       blurRadius: 3.0,
                              //       color: Color.fromRGBO(0, 0, 0, 0.5),
                              //     ),
                              //   ],
                              // ),
                              style: kExpenseHeadingTextStyle,
                            )
                          ],
                        ),
                        Text(
                          '8.5000.0',
                          // style: TextStyle(
                          //   color: white,
                          //   fontWeight: FontWeight.w600,
                          //   shadows: [
                          //     Shadow(
                          //       offset: Offset(1.0, 2.0),
                          //       blurRadius: 3.0,
                          //       color: Color.fromRGBO(0, 0, 0, 0.2),
                          //     ),
                          //   ],
                          // ),

                          style: kExpenseBodyTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.red.shade900,
                            ),
                            Text(
                              'Expense',
                              // style: TextStyle(
                              //   color: Colors.white70,
                              //   fontWeight: FontWeight.w600,
                              //   shadows: [
                              //     Shadow(
                              //       offset: Offset(1.0, 1.0),
                              //       blurRadius: 3.0,
                              //       color: Color.fromRGBO(0, 0, 0, 0.5),
                              //     ),
                              //   ],
                              // ),
                              style: kExpenseHeadingTextStyle,
                            )
                          ],
                        ),
                        Text(
                          '8.5000.0',
                          // style: TextStyle(
                          //   // color: Colors.red.shade900,
                          //   color: white,
                          //   fontWeight: FontWeight.w600,
                          //   shadows: [
                          //     Shadow(
                          //       offset: Offset(1.0, 2.0),
                          //       blurRadius: 3.0,
                          //       color: Color.fromRGBO(0, 0, 0, 0.2),
                          //     ),
                          //   ],
                          // ),
                          style: kExpenseBodyTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      // contentPadding:
      // EdgeInsets.zero, //for removing the default padding
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      minVerticalPadding: 0,
      onTap: () {},
      // tileColor: Colors.amber.shade50,
      dense: false,
      leading: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: MediaQuery.of(context).size.width * 0.11,
        height: MediaQuery.of(context).size.width * 0.11,
        decoration: BoxDecoration(
          color: darkPink.withOpacity(0.2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Transform.scale(
            scale: 1.5, child: SvgPicture.asset('assets/user_pp.svg')),
      ),
      title: Text(
        'Welcome back,',
        style: TextStyle(
          color: bodyTextColor.withOpacity(0.5),
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        'Meer M. Muazzam', //user name will go here.
        style: TextStyle(
          color: bodyTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
