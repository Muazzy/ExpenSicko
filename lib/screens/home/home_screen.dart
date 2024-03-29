// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/res/content.dart';
import 'package:expense_tracker_v2/res/image_paths.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/services/data_repository.dart';
import 'package:expense_tracker_v2/utils/transaction_conversions.dart';
import 'package:expense_tracker_v2/widgets/home/balance_card.dart';
import 'package:expense_tracker_v2/widgets/home/transaction_title.dart';
import 'package:expense_tracker_v2/widgets/home/user_tile.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentFirebaseUser = context.read<AuthRepository>().user;
    final userName = currentFirebaseUser.displayName;

    // const expensesEnums = ExpenseCategory.values;
    // const incomeEnums = IncomeCategory.values;

    // List<String> items = ['-1 true'];
    // String val =
    //     '${context.watch<DataRepository>().getFirstIsExpense.toString()} ${context.watch<DataRepository>().getFirstCategory}';

    return StreamBuilder<List<AppTransaction>>(
        stream: context.read<DataRepository>().transactionStream,
        builder: (context, snapshot) {
          List<AppTransaction> transactions = snapshot.data ?? [];
          // transactions = filter(
          //   context.watch<DataRepository>().getFirstIsExpense,
          //   transactions,
          //   context.watch<DataRepository>().getFirstCategory,
          // );
          if (snapshot.hasData) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserTile(
                    userImageHeroTag: userImageHeroTag,
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
                      // Navigator.pushNamed(context, '/userProfile'); //not including the
                    },
                    userImage: currentFirebaseUser.photoURL != null
                        ? Image.network(
                            currentFirebaseUser.photoURL ??
                                'https://img.icons8.com/ios-filled/512/who.png',
                          )
                        : Transform.scale(
                            scale: 1.5,
                            child: Image.asset(AppImagePaths.defaultUserImg),
                          ),
                    userName: userName ?? 'User',
                  ),
                  const SizedBox(height: 8),
                  BalanceCard(
                    //here i added snapshot.data cuz we want the balance card to show
                    balance:
                        addAllTransactionAmount(false, snapshot.data ?? []) -
                            addAllTransactionAmount(true, snapshot.data ?? []),
                    expenses:
                        addAllTransactionAmount(true, snapshot.data ?? []),
                    incomes:
                        addAllTransactionAmount(false, snapshot.data ?? []),
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
                                  color: AppColors.bodyTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // DropdownButton<String>(
                              //   icon: Icon(
                              //     Icons.arrow_drop_down,
                              //     color: AppColors.darkPurple,
                              //   ),
                              //   alignment: Alignment.centerRight,
                              //   //TODO add value param here
                              //   // value: ,
                              //   // value: 'hello',
                              //   //     // '${context.watch<DataRepositroy>().getFirstIsExpense.toString()} ${context.watch<DataRepositroy>().getFirstCategory}',
                              //   value: ,
                              //   items: [
                              //         DropdownMenuItem<String>(
                              //           value: '-1 true',
                              //           child: Text('All'),
                              //         )
                              //       ] +
                              //       expensesEnums
                              //           .map((e) => DropdownMenuItem<String>(
                              //                 value: '${e.index} true',
                              //                 child: CustomDropDownMenuItem(
                              //                   isExpense: true,
                              //                   catIcon: AppTransaction
                              //                       .staticGetcategoryIcon(
                              //                     true,
                              //                     expensesEnums[e.index],
                              //                   ),
                              //                   catString: AppTransaction
                              //                       .staticGetCategoryString(
                              //                     true,
                              //                     expensesEnums[e.index],
                              //                   ),
                              //                 ),
                              //               ))
                              //           .toList() +
                              //       incomeEnums
                              //           .map(
                              //             (e) => DropdownMenuItem<String>(
                              //               value: '${e.index} false',
                              //               child: CustomDropDownMenuItem(
                              //                 isExpense: false,
                              //                 catIcon: AppTransaction
                              //                     .staticGetcategoryIcon(
                              //                   false,
                              //                   incomeEnums[e.index],
                              //                 ),
                              //                 catString: AppTransaction
                              //                     .staticGetCategoryString(
                              //                   false,
                              //                   incomeEnums[e.index],
                              //                 ),
                              //               ),
                              //             ),
                              //           )
                              //           .toList(),
                              //   onChanged: (value) {
                              //     var exp = value!.split(' ')[1];
                              //     var cat = value.split(' ')[0];

                              //     bool isExpense;
                              //     if (exp == 'true') {
                              //       isExpense = true;
                              //     } else {
                              //       isExpense = false;
                              //     }
                              //     context
                              //         .read<DataRepository>()
                              //         .toggleFirstExpense(isExpense);
                              //     print(context
                              //         .read<DataRepository>()
                              //         .getFirstIsExpense);
                              //     context
                              //         .read<DataRepository>()
                              //         .toggleFirstCategory(int.parse(cat));
                              //     print(context
                              //         .read<DataRepository>()
                              //         .getFirstCategory);
                              //   },
                              //   underline: SizedBox.shrink(),
                              // ),
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
                                color: AppColors.darkPink.withOpacity(0.5),
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

class CustomDropDownMenuItem extends StatelessWidget {
  const CustomDropDownMenuItem({
    Key? key,
    required this.catString,
    required this.catIcon,
    required this.isExpense,
  }) : super(key: key);

  final String catString;
  final IconData catIcon;
  final bool isExpense;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isExpense
                ? AppColors.darkPink.withOpacity(0.2)
                : AppColors.darkPurple.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: Icon(
              catIcon,
              color: isExpense ? AppColors.darkPurple : AppColors.darkPink,
              size: 16,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          catString,
          style: TextStyle(
            color: AppColors.bodyTextColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
