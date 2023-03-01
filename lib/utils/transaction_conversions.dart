import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/utils/date_utils.dart';

double addAllTransactionAmount(
  bool isExpense,
  List<AppTransaction> transactions,
) =>
    transactions
        .where(
          (transactionElement) => transactionElement.isExpense == isExpense,
        )
        .map((e) => e.amount)
        .fold(
          0.0,
          (previousValue, element) => previousValue + element,
        );

getPieChartData(bool isExpense, List<AppTransaction> transactions) {
  Map<String, dynamic> pieChartData = {};
  for (var element in transactions) {
    if (element.isExpense == isExpense) {
      if (element.amount != 0) {
        pieChartData.update(
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
    }
  }
  return pieChartData;
}

final thisWeek = getThisWeek();

Map<int, dynamic> getBarChartData(List<AppTransaction> transactions) {
  Map<int, dynamic> barChartData = {
    0: {
      'totalIncome': 0.0,
      'totalExpense': 0.0,
    },
    1: {
      'totalIncome': 0.0,
      'totalExpense': 0.0,
    },
    2: {
      'totalIncome': 0.0,
      'totalExpense': 0.0,
    },
    3: {
      'totalIncome': 0.0,
      'totalExpense': 0.0,
    },
    4: {
      'totalIncome': 0.0,
      'totalExpense': 0.0,
    },
    5: {
      'totalIncome': 0.0,
      'totalExpense': 0.0,
    },
    6: {
      'totalIncome': 0.0,
      'totalExpense': 0.0,
    },
  };

  for (int i = 0; i < thisWeek.length; i++) {
    for (var transactionItem in transactions) {
      if (isSameDay(thisWeek[i], transactionItem.dateTime) &&
          transactionItem.isExpense) {
        barChartData.update(
          i,
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

      if (isSameDay(thisWeek[i], transactionItem.dateTime) &&
          !transactionItem.isExpense) {
        barChartData.update(
          i,
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
  return barChartData;
}

Map<int, double> getBarChartModifiedData(
  // Map<int, dynamic> transactions,
  List<AppTransaction> transactions,
  bool isExpense,
) {
  Map<int, dynamic> modifiedTransactions = getBarChartData(transactions);
  return modifiedTransactions.map((key, value) =>
      MapEntry(key, isExpense ? value['totalExpense'] : value['totalIncome']));
}
