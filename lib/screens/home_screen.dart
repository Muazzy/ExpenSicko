// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/styles/glassmorphism.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ListTile(
            leading: Icon(
              Icons.supervised_user_circle_rounded,
            ),
            title: Text('Welcome back,'),
            subtitle: Text('Meer M. Muazzam'),
          ),
          const SizedBox(height: 24),
          Container(
            height:
                MediaQuery.of(context).size.width * .55, //this wont be needed
            width: MediaQuery.of(context).size.width * .85,
            decoration: BoxDecoration(
              // color: darkPurple,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(-0.8, -0.8),
                stops: [0.0, 0.5, 0.5, 1],
                colors: [
                  darkPurple,
                  darkPurple,
                  darkPurple.withOpacity(0.9),
                  darkPurple.withOpacity(0.95),
                ],
                tileMode: TileMode.repeated,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '',
                      style: TextStyle(
                        color: darkPurple,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                        ],
                      ),
                      children: [
                        TextSpan(
                          text: '10043.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GlassMorphism(
                    start: 0.5, //0.6
                    end: 0.2, //0.3
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.green,
                                  ),
                                  Text('Income')
                                ],
                              ),
                              Text('8.5000.0'),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: Colors.red,
                                  ),
                                  Text('Expense')
                                ],
                              ),
                              Text('8.5000.0'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
