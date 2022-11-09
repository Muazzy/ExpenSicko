// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/constants/textstyles.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/services/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentFirebaseUser = context.read<AuthRepository>().user;
    final userName = currentFirebaseUser.displayName;

    return StreamBuilder<List<AppTransaction>>(
        stream: context.read<DataRepositroy>().transactionStream,
        builder: (context, snapshot) {
          final transactions = snapshot.data ?? [];
          if (snapshot.hasData) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserTile(
                    onTap: () {
                      context.read<AuthRepository>().signOut(context);
                    },
                    userImage: Image.network(
                      currentFirebaseUser.photoURL ??
                          'https://img.icons8.com/ios-filled/512/who.png',
                    ),
                    userName: userName,
                  ),
                  const SizedBox(height: 8),
                  BalanceCard(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.075,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recent transactions',
                          style: TextStyle(
                            color: bodyTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: darkPurple,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.075),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          isThreeLine: false,
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            decoration: BoxDecoration(
                              color: transactions[index].color.shade100,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                transactions[index].icon,
                                size: 32,
                                color: transactions[index].color.shade900,
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                transactions[index].name,
                                style: kTitleTextStyle,
                              ),
                              Text(
                                transactions[index].amountString,
                                style: kTitleTextStyle,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                transactions[index].categoryString,
                                style: kSubtitleTextStyle,
                              ),
                              Text(
                                transactions[index].dateString,
                                style: kSubtitleTextStyle,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('something went wrong ${snapshot.error}'),
            );
          }
          return Container();
        });
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.075),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(-0.8, -0.8),
            stops: [0.0, 0.5, 0.5, 1],
            colors: [
              darkPurple.withOpacity(1),
              darkPurple.withOpacity(1),
              darkPurple.withOpacity(0.8),
              darkPurple.withOpacity(0.95),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: bgPurplenew,
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(10),
                  //   ),
                  //   border: Border.all(
                  //     color: darkPink.withOpacity(0.5),
                  //     width: 0.5,
                  //   ),
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment(0.8, 0.15),
                      stops: [0.0, 0.5, 0.5, 1],
                      colors: [
                        // darkPurple.withOpacity(1),
                        // darkPurple.withOpacity(1),
                        // darkPink.withOpacity(0.8),
                        // darkPink.withOpacity(0.95),
                        darkPurple.withOpacity(0.5),
                        darkPurple.withOpacity(0.5),
                        darkPurple.withOpacity(0.3),
                        darkPurple.withOpacity(0.45),

                        // Color.fromRGBO(232, 122, 140, 1),
                        // Color.fromARGB(207, 232, 122, 140),
                      ],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.green.shade700,
                                  size: 14,
                                ),
                                Text(
                                  'Income',
                                  style: kExpenseHeadingTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              '8.5000.0',
                              style: kExpenseBodyTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red.shade700,
                                  size: 14,
                                ),
                                Text(
                                  'Expense',
                                  style: kExpenseHeadingTextStyle,
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              '8.5000.0',
                              style: kExpenseBodyTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.onTap,
    required this.userImage,
    required this.userName,
  }) : super(key: key);
  final void Function() onTap;
  final Widget userImage;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.075),
      child: ListTile(
        isThreeLine: false,
        // contentPadding:
        // EdgeInsets.zero, //for removing the default padding
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        minVerticalPadding: 0,
        // onTap: onTap,
        // tileColor: Colors.amber.shade50,
        dense: false,
        trailing: IconButton(
          tooltip: 'Logout',
          onPressed: onTap,
          icon: Icon(
            Icons.logout,
            color: darkPink,
          ),
        ),
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
            scale: 1,
            // child: SvgPicture.asset('assets/user_pp.svg'),
            child: userImage,
          ),
        ),
        title: Text(
          'Welcome back,',
          style: TextStyle(
            color: bodyTextColor.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        subtitle: Text(
          userName!, //user name will go here.
          style: TextStyle(
            color: bodyTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
