import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/model/data.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/screens/example.dart';
import 'package:expense_tracker_v2/widgets/stats/category_item_customtext.dart';
import 'package:expense_tracker_v2/widgets/stats/custom_switch.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

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
    // for (var day in thisWeek) {
    //   for (var transactionItem in transactions) {
    //     if (AppTransaction.isSameDay(day, transactionItem.dateTime) &&
    //         transactionItem.isExpense) {
    //       totalIncomeAndExpenseOfEachDayThisWeek.update(
    //         day,
    //         (value) => {
    //           'totalExpense': value['totalExpense'] + transactionItem.amount,
    //           'totalIncome': value['totalIncome'],
    //         },
    //         ifAbsent: () => {
    //           'totalExpense': transactionItem.amount,
    //           'totalIncome': 0,
    //         },
    //       );
    //     }

    //     if (AppTransaction.isSameDay(day, transactionItem.dateTime) &&
    //         !transactionItem.isExpense) {
    //       totalIncomeAndExpenseOfEachDayThisWeek.update(
    //         day,
    //         (value) => {
    //           'totalIncome': value['totalIncome'] + transactionItem.amount,
    //           'totalExpense': value['totalExpense'],
    //         },
    //         ifAbsent: () => {
    //           'totalIncome': transactionItem.amount,
    //           'totalExpense': 0,
    //         },
    //       );
    //     }
    //   }
    // }

    //thisWeek // list of days of this week

    return Consumer<Data>(
      builder: (context, data, child) {
        // child:
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSwitch(
                onPressed: () {
                  data.toggleExpense();
                },
                isExpense: data.getIsExpense,
                width: width,
                padding: 16,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                              sections: data.pieChData
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
                          children: data.pieChartData
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      child: Text(
                        '${AppTransaction.formatDate(data.thisWeek[0])} - ${AppTransaction.formatDate(
                          data.thisWeek[data.thisWeek.length - 1],
                        )}', //this will be handled dynamically.
                        // '',
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
              BarChartSample6(expenseAndIncomes: data.barChartData),
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
      },
    );
  }
}
