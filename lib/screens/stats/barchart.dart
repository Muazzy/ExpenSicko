import 'package:expense_tracker_v2/res/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  BarChartWidget(
      {super.key, required this.isExpense, this.transactions = const {}});

  final bool isExpense;
  Map<int, double> transactions;
  static const betweenSpace = 0.2;

  BarChartGroupData generateGroupData({
    required int index,
    required double value,
  }) {
    return BarChartGroupData(
      x: index,
      groupVertically: true,
      barRods: rods(value, isExpense),
    );
  }

  Map<int, double> getValues(Map<int, double> transactions) {
    if (transactions.isEmpty) {
      return {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
      };
    }

    // print('pehle $transactions');

    double maxNum = transactions.values
        .reduce((current, next) => current > next ? current : next);
    //to solve NaN problem
    if (maxNum != 0) {
      transactions.updateAll((key, value) => (value / maxNum) * 8);
    }
    // print(transactions);
    return transactions;
  }

  // Map<int, double> getValuesplusplus(Map<int, double> transactions) {
  //   double maxNum = transactions.values
  //       .reduce((current, next) => current > next ? current : next);

  //   transactions.updateAll((key, value) => (value / maxNum) * 8);

  //   return transactions;
  // }

  // List<BarChartRodData> rods(double expense, double income) {
  //   if (expense != 0 && income != 0) {
  //     return [
  //       BarChartRodData(
  //         fromY: 0,
  //         toY: expense,
  //         color: AppColors.darkPink,
  //         width: 8,
  //       ),
  //       BarChartRodData(
  //         fromY: expense + betweenSpace,
  //         // divided by most highest expense or income & multiplied by 8.
  //         toY: (expense + betweenSpace + income) / 8 * 8,
  //         color: AppColors.darkPurple,
  //         width: 8,
  //       ),
  //     ];
  //   }
  //   return [
  //     BarChartRodData(
  //       fromY: 0,
  //       toY: 8,
  //       color: AppColors.bodyTextColor.withOpacity(0.1),
  //       width: 8,
  //     ),
  //   ];
  // }

  List<BarChartRodData> rods(double value, bool isExpense) {
    if (value != 0) {
      return [
        BarChartRodData(
          fromY: 0,
          toY: value,
          color: isExpense ? AppColors.darkPink : AppColors.darkPurple,
          width: 8,
        ),
        BarChartRodData(
          toY: 8 - value > 0 ? value + 8 - value : 0,
          fromY: value,
          color: AppColors.bodyTextColor.withOpacity(0.1),
          width: 8,
        )
      ];
    }
    return [
      BarChartRodData(
        fromY: 0,
        toY: 8,
        color: AppColors.bodyTextColor.withOpacity(0.1),
        width: 8,
      ),
    ];
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: AppColors.bodyTextColor.withOpacity(0.5),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'MO';
        break;
      case 1:
        text = 'TU';
        break;
      case 2:
        text = 'WE';
        break;
      case 3:
        text = 'TH';
        break;
      case 4:
        text = 'FR';
        break;
      case 5:
        text = 'SA';
        break;
      case 6:
        text = 'SU';
        break;
      default:
        text = 'N/A';
    }
    return SideTitleWidget(
      axisSide: AxisSide.top,
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(text, style: style),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(getValues(transactions));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: AspectRatio(
        aspectRatio: 2,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceBetween,
            maxY: 8.5 + betweenSpace,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(),
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: bottomTitles,
                  reservedSize: 30,
                ),
              ),
            ),
            barTouchData: BarTouchData(enabled: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            barGroups: getValues(transactions)
                .entries
                .map((e) => generateGroupData(index: e.key, value: e.value))
                .toList(),
          ),
        ),
      ),
    );
  }
}
