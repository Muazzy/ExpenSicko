// import 'package:example/legend_widget.dart';
import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Credit: https://dribbble.com/shots/10072126-Heeded-Dashboard
class BarChartSample6 extends StatelessWidget {
  const BarChartSample6({super.key});

  static const betweenSpace = 0.2;

  BarChartGroupData generateGroupData(
    int x,
    double expense,
    double income,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: expense,
          color: darkPink,
          width: 8,
        ),
        BarChartRodData(
          fromY: expense + betweenSpace,
          toY: expense + betweenSpace + income,
          color: darkPurple,
          width: 8,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: bodyTextColor.withOpacity(0.5),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'SU';
        break;
      case 1:
        text = 'MO';
        break;
      case 2:
        text = 'TU';
        break;
      case 3:
        text = 'WE';
        break;
      case 4:
        text = 'TH';
        break;
      case 5:
        text = 'FR';
        break;
      case 6:
        text = 'SA';
        break;
      default:
        text = '';
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: AspectRatio(
          aspectRatio: 2,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
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
              barGroups: [
                generateGroupData(
                  0,
                  2,
                  3,
                ),
                generateGroupData(
                  1,
                  2,
                  5,
                ),
                generateGroupData(
                  2,
                  1.3,
                  3.1,
                ),
                generateGroupData(
                  3,
                  3.1,
                  4,
                ),
                generateGroupData(
                  4,
                  0.8,
                  3.3,
                ),
                generateGroupData(
                  5,
                  2,
                  5.6,
                ),
                generateGroupData(
                  6,
                  1.3,
                  3.2,
                ),
              ],
              maxY: 8 + (betweenSpace * 1),
            ),
          ),
        ),
      ),
    );
  }
}
