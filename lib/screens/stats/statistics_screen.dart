import 'dart:typed_data';

import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/services/data_repository.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/screens/stats/barchart.dart';
import 'package:expense_tracker_v2/utils/date_utils.dart';
import 'package:expense_tracker_v2/utils/transaction_conversions.dart';
import 'package:expense_tracker_v2/widgets/stats/category_item_customtext.dart';
import 'package:expense_tracker_v2/widgets/stats/custom_switch.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../home/pdf_preview_screen.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  late Uint8List? pieChartImage;
  late Uint8List? barChartImage;

  ScreenshotController pieChartSSController = ScreenshotController();

  ScreenshotController barChartSSController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isExpense = context.watch<DataRepository>().getIsExpense;
    final List<DateTime> thisWeek = getThisWeek();

    return StreamBuilder<List<AppTransaction>>(
      stream: context.read<DataRepository>().transactionStream,
      builder: (context, snapshot) {
        final transactions = snapshot.data ?? [];
        final Map<String, dynamic> pieChartData =
            getPieChartData(isExpense, transactions);
        final Map<int, double> barChartData =
            getBarChartModifiedData(transactions, isExpense);
        // print('bar Chart Data: $barChartData');
        // print(getBarChartModifiedData(barChartData, isExpense));
        if (snapshot.hasData) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSwitch(
                  onPressed: () {
                    context.read<DataRepository>().toggleExpense();
                  },
                  isExpense: isExpense,
                  width: width,
                  padding: 16,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Screenshot(
                    controller: pieChartSSController,
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
                                    sections: pieChartData.isNotEmpty
                                        ? pieChartData
                                            .map((category, valueMap) =>
                                                MapEntry(
                                                  category,
                                                  PieChartSectionData(
                                                    showTitle: false,
                                                    color: valueMap['color'],
                                                    radius: 24.0,
                                                    value:
                                                        valueMap['totalAmount'],
                                                  ),
                                                ))
                                            .values
                                            .toList()
                                        : [
                                            PieChartSectionData(
                                              showTitle: false,
                                              color: AppColors.bodyTextColor
                                                  .withOpacity(0.2),
                                              radius: 24.0,
                                              value: 69,
                                            ),
                                          ]),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Column(
                              children: pieChartData.isNotEmpty
                                  ? pieChartData
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
                                      .toList()
                                  : [
                                      CategoryItem(
                                        categoryName: 'No Entries',
                                        categoryColor: AppColors.bodyTextColor
                                            .withOpacity(0.2),
                                        borderWidth: 3,
                                      )
                                    ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          color: AppColors.bodyTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          '${formatDate(thisWeek[0])} - ${formatDate(
                            thisWeek[thisWeek.length - 1],
                          )}', //this will be handled dynamically.
                          // '',
                          style: TextStyle(
                            color: AppColors.bodyTextColor.withOpacity(0.5),
                            // fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Screenshot(
                  controller: barChartSSController,
                  child: BarChartWidget(
                    isExpense: isExpense,
                    transactions: barChartData,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const CategoryItem(
                        categoryName: 'Income',
                        categoryColor: AppColors.darkPurple,
                        borderWidth: 8,
                      ),
                      const CategoryItem(
                        categoryName: 'Expense',
                        categoryColor: AppColors.darkPink,
                        borderWidth: 8,
                      ),
                      CategoryItem(
                        categoryName: 'Not yet',
                        categoryColor: AppColors.bodyTextColor.withOpacity(0.3),
                        borderWidth: 8,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Get monthly report'),
                      IconButton(
                        onPressed: () async {
                          try {
                            pieChartImage =
                                await pieChartSSController.capture();
                            barChartImage =
                                await barChartSSController.capture();
                          } catch (e) {
                            debugPrint(e.toString());
                          }

                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfPreviewScreen(
                                  barChartImage: barChartImage!,
                                  pieChartImage: pieChartImage!,
                                  isExpense: isExpense,
                                  transactions: transactions,
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.print),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('something went wrong ${snapshot.error}'),
          );
        }
        return Container();
      },
    );
  }
}
