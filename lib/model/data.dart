import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:flutter/widgets.dart';

class Data with ChangeNotifier {
  Data() {
    init();
  }

  void init() {
    updatePieChart();
    createThisWeek();
    updateTotalIncomeAndExpenseOfEachDay();
  }

  //this will be dynamically fetched
  List<AppTransaction> transactions = [
    AppTransaction(
      amount: 10,
      name: 'aise hee',
      dateTime: DateTime(2022, 10, 31),
      document: null,
      category: ExpenseCategory.education,
      isExpense: true,
    ),
    AppTransaction(
      amount: 80,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.passive,
      isExpense: false,
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
      amount: 80,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.passive,
      isExpense: false,
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
      amount: 80,
      name: 'aise hee',
      dateTime: DateTime.now(),
      document: null,
      category: IncomeCategory.freelancing,
      isExpense: false,
    ),
  ];

  //index for root widget, 0--> home, 1--> stats
  int _currentIndex = 0;

  int get getCurrentIndex => _currentIndex;

  set currentIndex(int v) {
    _currentIndex = v;
    notifyListeners();
  }

  bool _isExpense = true;

  bool get getIsExpense => _isExpense;

  void toggleExpense() {
    _isExpense = !_isExpense;
    pieChData.clear();
    notifyListeners();
    updatePieChart();
    // print(_isExpense);
    print(barChartData);
  }

  final pieChartData = <String, dynamic>{};

  Map<String, dynamic> get pieChData => pieChartData;

  void updatePieChart() {
    for (var element in transactions) {
      if (element.isExpense == _isExpense) {
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

    notifyListeners();
  }

  final List<DateTime> _thisWeek = [];
  List<DateTime> get thisWeek => _thisWeek;
  void createThisWeek() {
    for (int i = 0; i < 7; i++) {
      _thisWeek.add(
        AppTransaction.mostRecentMondayFromCurrentDay.add(
          Duration(days: i),
        ),
      );
    }
    notifyListeners();
  }

  final barChartData = <int, dynamic>{};
  Map<int, dynamic> get getBarchartData => barChartData;

  void updateTotalIncomeAndExpenseOfEachDay() {
    for (int i = 0; i < thisWeek.length; i++) {
      for (var transactionItem in transactions) {
        if (AppTransaction.isSameDay(thisWeek[i], transactionItem.dateTime) &&
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

        if (AppTransaction.isSameDay(thisWeek[i], transactionItem.dateTime) &&
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

    notifyListeners();
  }
}
