// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/constants/content.dart';
import 'package:expense_tracker_v2/constants/image_paths.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/services/data_repository.dart';
import 'package:expense_tracker_v2/utils/transaction_conversions.dart';
import 'package:expense_tracker_v2/widgets/home/balance_card.dart';
import 'package:expense_tracker_v2/widgets/home/transaction_title.dart';
import 'package:expense_tracker_v2/widgets/home/user_tile.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          actionFunction: () {
                            context.read<AuthRepository>().signOut(context);
                          },
                          dialogBody: logoutDialogBody,
                          dialogHeading: logoutDialogHeading,
                          actionButtonText: 'Logout',
                        ),
                      );
                    },
                    onProfileImageTap: () {
                      Navigator.pushNamed(context, '/userProfile');
                    },
                    userImage: currentFirebaseUser.photoURL != null
                        ? Image.network(
                            currentFirebaseUser.photoURL ??
                                'https://img.icons8.com/ios-filled/512/who.png',
                          )
                        : Transform.scale(
                            scale: 1.5,
                            child: SvgPicture.asset(defaultUserImg),
                          ),
                    userName: userName ?? 'User',
                  ),
                  const SizedBox(height: 8),
                  BalanceCard(
                    balance: addAllTransactionAmount(false, transactions) -
                        addAllTransactionAmount(true, transactions),
                    expenses: addAllTransactionAmount(true, transactions),
                    incomes: addAllTransactionAmount(false, transactions),
                  ),
                  const SizedBox(height: 16),
                  transactions.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.075,
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
                        )
                      : SizedBox.shrink(),
                  const SizedBox(height: 8),
                  transactions.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.075,
                            ),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return TransactionTile(
                                transaction: transactions[index],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              'Click on the ➕ button to add a transaction.\n',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: darkPink.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                fontSize: 12,
                              ),
                            ),
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
