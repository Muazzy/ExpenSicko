// import 'package:expense_tracker_v2/model/transaction_model.dart';
// import 'package:expense_tracker_v2/utils/date_utils.dart';
// import 'package:flutter/widgets.dart';

// class Data with ChangeNotifier {
//   Data() {
//     init();
//   }

//   void init() {
//     updatePieChart();
//     createThisWeek();
//     updateTotalIncomeAndExpenseOfEachDay();
//   }

//   //this will be dynamically fetched
//   List<AppTransaction> transactions = [
//     // AppTransaction.formatDate(dateTime)
//     // AppTransaction(
//     //   uid: '',
//     //   amount: 10,
//     //   name: 'aise hee',
//     //   dateTime: DateTime(2022, 10, 31),
//     //   document: null,
//     //   category: 1,
//     //   isExpense: true,
//     // ),
//     // AppTransaction(
//     //   uid: '',
//     //   amount: 80,
//     //   name: 'aise hee',
//     //   dateTime: DateTime.now(),
//     //   document: null,
//     //   category: 2,
//     //   isExpense: false,
//     // ),
//     // AppTransaction(
//     //   uid: '',
//     //   amount: 10,
//     //   name: 'aise hee',
//     //   dateTime: DateTime.now(),
//     //   document: null,
//     //   category: 0,
//     //   isExpense: true,
//     // ),
//     // AppTransaction(
//     //   uid: '',
//     //   amount: 80,
//     //   name: 'aise hee',
//     //   dateTime: DateTime.now(),
//     //   document: null,
//     //   category: 2,
//     //   isExpense: false,
//     // ),
//     // AppTransaction(
//     //   uid: '',
//     //   amount: 10,
//     //   name: 'aise hee',
//     //   dateTime: DateTime.now(),
//     //   document: null,
//     //   category: 4,
//     //   isExpense: true,
//     // ),
//     // AppTransaction(
//     //   uid: '',
//     //   amount: 80,
//     //   name: 'aise hee',
//     //   dateTime: DateTime.now(),
//     //   document: null,
//     //   category: 4,
//     //   isExpense: false,
//     // ),
//   ];

//   final barChartData = <int, dynamic>{};
//   Map<int, dynamic> get getBarchartData => barChartData;

//   void updateTotalIncomeAndExpenseOfEachDay() {
//     for (int i = 0; i < thisWeek.length; i++) {
//       for (var transactionItem in transactions) {
//         if (isSameDay(thisWeek[i], transactionItem.dateTime) &&
//             transactionItem.isExpense) {
//           barChartData.update(
//             i,
//             (value) => {
//               'totalExpense': value['totalExpense'] + transactionItem.amount,
//               'totalIncome': value['totalIncome'],
//             },
//             ifAbsent: () => {
//               'totalExpense': transactionItem.amount,
//               'totalIncome': 0,
//             },
//           );
//         }

//         if (isSameDay(thisWeek[i], transactionItem.dateTime) &&
//             !transactionItem.isExpense) {
//           barChartData.update(
//             i,
//             (value) => {
//               'totalIncome': value['totalIncome'] + transactionItem.amount,
//               'totalExpense': value['totalExpense'],
//             },
//             ifAbsent: () => {
//               'totalIncome': transactionItem.amount,
//               'totalExpense': 0,
//             },
//           );
//         }
//       }
//     }

//     notifyListeners();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/utils/custom_snackbar.dart';
import 'package:flutter/widgets.dart';

class DataRepositroy extends ChangeNotifier {
  final FirebaseFirestore _db;
  DataRepositroy(this._db);

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
    pieChartData.clear();
    notifyListeners();
    // updatePieChartData();
    // // print(_isExpense);
    // print(barChartData);
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

  CollectionReference get _transactionCollection =>
      _db.collection('transactions');

  /*firstly get the stream of snapshot in the transactionCollection of current 
  user with the help of uid, then map these snapshots into docs (the actual data of the snapshot that we need).
  After that convert the stream of docs in to List of AppTransaction model*/
  Stream<List<AppTransaction>> get transactionStream => _transactionCollection
      .where('uid', isEqualTo: AuthRepository.currentUserUid)
      .snapshots()
      .map((snapshot) => snapshot.docs)
      .map((docs) =>
          docs.map((doc) => AppTransaction.fromDocument(doc)).toList());

  Future<void> addTransaction(
    String name,
    double amount,
    DateTime dateTime,
    bool isExpense,
    int category,
    BuildContext context,
  ) async {
    try {
      _transactionCollection.add({
        'name': name,
        'amount': amount,
        'dateTime': Timestamp.fromDate(dateTime),
        'isExpense': isExpense,
        'category': category,
        'uid': AuthRepository.currentUserUid,
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  final pieChartData = <String, dynamic>{};

  // void updatePieChartData() {
  //   transactionStream.listen(
  //     (transactions) {
  //       for (var element in transactions) {
  //         if (element.isExpense == _isExpense) {
  //           pieChartData.update(
  //             element.categoryString,
  //             (value) => {
  //               'totalAmount': value['totalAmount'] + element.amount,
  //               'color': element.color,
  //             },
  //             ifAbsent: () => {
  //               'totalAmount': element.amount,
  //               'color': element.color,
  //             },
  //           );
  //         }
  //       }
  //     },
  //     onDone: notifyListeners,
  //     onError: (e) => print(e),
  //   );
  // }
}
