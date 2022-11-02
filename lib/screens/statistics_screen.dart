import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/screens/example.dart';
import 'package:expense_tracker_v2/widgets/stats/category_item_customtext.dart';
import 'package:expense_tracker_v2/widgets/stats/custom_switch.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  bool isExpense = false;
  //this will change.
  List<AppTransaction> transactions = [
    AppTransaction(
      amount: 1,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.passive,
      isExpense: false,
    ),
    AppTransaction(
      amount: 2,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.freelancing,
      isExpense: false,
    ),
    AppTransaction(
      amount: 3,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.freelancing,
      isExpense: false,
    ),
    AppTransaction(
      amount: 4,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.freelancing,
      isExpense: false,
    ),
    AppTransaction(
      amount: 5,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.freelancing,
      isExpense: false,
    ),
    AppTransaction(
      amount: 6,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.freelancing,
      isExpense: false,
    ),
    AppTransaction(
      amount: 7,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.freelancing,
      isExpense: false,
    ),
    AppTransaction(
      amount: 8,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: ExpenseCategory.entertaintment,
      isExpense: true,
    ),
    AppTransaction(
      amount: 9,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: ExpenseCategory.home,
      isExpense: true,
    ),
    AppTransaction(
      amount: 10,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: ExpenseCategory.education,
      isExpense: true,
    ),
    AppTransaction(
      amount: 10,
      name: 'aise hee',
      dateTime: DateTime(2022, 1, 8),
      document: null,
      category: ExpenseCategory.education,
      isExpense: true,
    ),
    AppTransaction(
      amount: 80,
      name: 'aise hee',
      dateTime: DateTime(2022, 1, 8),
      document: null,
      category: ExpenseCategory.education,
      isExpense: false,
    ),
  ];

  final data = <String, dynamic>{};
  List<DateTime> thisWeek = [];
  final totalIncomeAndExpenseOfEachDayThisWeek = {};

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    for (var element in transactions) {
      if (element.isExpense == isExpense) {
        data.update(
          element.categoryString,
          (value) => {
            'totalAmount': value['totalAmount'] + element.amount,
            'color': element.color,
          },
          ifAbsent: () => {
            'totalAmount': element.amount,
            'color': element.color,
          },
        );
      }
      //  else {
      //   print(element.category);
      // }
    }

    // for (var element in transactions) {
    //   for (var day in thisWeek) {
    //     if (element.dateTime == day && element.isExpense) {
    //       totalIncomeAndExpenseOfEachDayThisWeek.update(
    //         day,
    //         (value) => {
    //           'totalAmount': value['totalAmount'] + element.amount,
    //           'color': element.color,
    //         },
    //         ifAbsent: () => {
    //           'totalAmount': element.amount,
    //           'color': element.color,
    //         },
    //       );
    //     }
    //   }
    // }
//TODO: kal tak ye done krna hai.,
    for (var day in thisWeek) {
      for (var transactionItem in transactions) {
        if (day != transactionItem.dateTime && transactionItem.isExpense) {
          totalIncomeAndExpenseOfEachDayThisWeek.update(
            day,
            (value) => {
              'totalExpense': value['totalExpense'] + transactionItem.amount,
              'totalIncome': value['totalIncome'],
            },
            ifAbsent: () => {
              'totalExpense': transactionItem.amount,
              'totalIncome': 0,
            },
          );
        }

        if (day != transactionItem.dateTime && !transactionItem.isExpense) {
          totalIncomeAndExpenseOfEachDayThisWeek.update(
            day,
            (value) => {
              'totalIncome': value['totalIncome'] + transactionItem.amount,
              'totalExpense': value['totalExpense'],
            },
            ifAbsent: () => {
              'totalIncome': transactionItem.amount,
              'totalExpense': 0,
            },
          );
        }
      }
    }

    //thisWeek // list of days of this week
    for (int i = 0; i < 7; i++) {
      thisWeek.add(
        AppTransaction.mostRecentMondayFromCurrentDay.add(
          Duration(days: i),
        ),
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSwitch(
            onPressed: () {
              setState(() {
                data.clear(); //to clear all the expense entries before adding the income entries & vice versa.
                isExpense = !isExpense;
              });

              // print(thisWeek[0].day);
              print(totalIncomeAndExpenseOfEachDayThisWeek);
            },
            isExpense: isExpense,
            width: width,
            padding: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(show: true),
                          sectionsSpace: 0,
                          startDegreeOffset: 270,
                          sections: data
                              .map((category, valueMap) => MapEntry(
                                    category,
                                    PieChartSectionData(
                                      showTitle: false,
                                      color: valueMap['color'],
                                      radius: 24.0,
                                      value: valueMap['totalAmount'],
                                    ),
                                  ))
                              .values
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Column(
                      children: data
                          .map(
                            (category, valueMap) => MapEntry(
                              category,
                              CategoryItem(
                                borderWidth: 3,
                                categoryName: category,
                                categoryColor: valueMap['color'],
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This Week',
                  style: TextStyle(
                    color: bodyTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  //TODO make this dyanmic too.
                  child: Text(
                    '${AppTransaction.formatDate(thisWeek[0])} - ${AppTransaction.formatDate(
                      thisWeek[thisWeek.length - 1],
                    )}', //this will be handled dynamically.
                    style: TextStyle(
                      color: bodyTextColor.withOpacity(0.5),
                      // fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //TODO: bar chart dyanamically
          //make this dynamical tommorow.
          const BarChartSample6(expenseAndIncomes: []),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CategoryItem(
                  categoryName: 'Income',
                  categoryColor: darkPurple,
                  borderWidth: 8,
                ),
                const CategoryItem(
                  categoryName: 'Expense',
                  categoryColor: darkPink,
                  borderWidth: 8,
                ),
                CategoryItem(
                  categoryName: 'Not yet',
                  categoryColor: bodyTextColor.withOpacity(0.3),
                  borderWidth: 8,
                ),
              ],
            ),
          ),
          const SizedBox(height: 42),
        ],
      ),
    );
  }
}
