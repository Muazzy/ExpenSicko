import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/utils/custom_snackbar.dart';
import 'package:flutter/widgets.dart';

class DataRepository extends ChangeNotifier {
  final FirebaseFirestore _db;
  DataRepository(this._db);

  bool _getFirstisExpense = true;

  bool get getFirstIsExpense => _getFirstisExpense;

  void toggleFirstExpense(bool isExpense) {
    _getFirstisExpense = isExpense;
    notifyListeners();
  }

  int _getFirstCategory = 0;

  int get getFirstCategory => _getFirstCategory;

  void toggleFirstCategory(int category) {
    _getFirstCategory = category;
    notifyListeners();
  }

  //index for root widget, 0--> home, 1--> stats
  int _currentIndex = 0;

  int get getCurrentIndex => _currentIndex;

  set currentIndex(int v) {
    _currentIndex = v;
    notifyListeners();
  }

  //FOR STATS SCREEN
  bool _isExpense = true;

  bool get getIsExpense => _isExpense;

  void toggleExpense() {
    _isExpense = !_isExpense;
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

  Future<void> delete(S) async {}
}
