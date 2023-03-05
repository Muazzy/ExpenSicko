import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/res/content.dart';
import 'package:expense_tracker_v2/utils/date_utils.dart';
import 'package:flutter/material.dart';

enum ExpenseCategory {
  entertaintment,
  groceries,
  home,
  health,
  food,
  education,
  travel,
  others,
}

enum IncomeCategory {
  salary,
  passive,
  freelancing,
  rental,
  others,
}

class AppTransaction {
  final double amount;
  final String name;
  final DateTime dateTime;
  // final String uid;
  final int category;
  final bool isExpense;
  final DocumentReference? _document;

  AppTransaction(
    this._document, {
    required this.amount,
    required this.name,
    required this.dateTime,
    required this.category,
    required this.isExpense,
  });

  //convert json to AppTransaction object.
  AppTransaction.fromDocument(DocumentSnapshot transactionDoc)
      : this._fromMap(
          transactionDoc.data() as Map<String, dynamic>,
          transactionDoc.reference,
        );

  //helper function to convert document snapshot (map) into a AppTransaction Object.
  AppTransaction._fromMap(Map<String, dynamic> data, this._document)
      : name = data['name'] ?? '',
        amount = data['amount'] ?? 0,
        category = data['category'] ?? -1,
        isExpense = data['isExpense'] ?? true,
        dateTime = data['dateTime']?.toDate() ?? DateTime.now();

// // update this.
//   Map toMap() {
//     return {
//       'name': name,
//       'amount': amount,
//       'date': Timestamp.fromDate(dateTime),
//       'isExpense': isExpense,
//       'category': category,
//       'uid': uid,
//     };
//   }

  String get docId => _document!.id;

  String get dateTimeString => dateTime.toString();

  Future<void> delete() => _document!.delete();

  Future<void> updateWith({
    double? amount,
    String? name,
    int? category,
    DateTime? dataTime,
    bool? isExpense,
  }) {
    return _document!.update({
      if (amount != null) 'amount': amount,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      'dateTime': dateTime,
      if (isExpense != null) 'isExpense': isExpense,
    });
  }

  String get amountString {
    return isExpense
        ? '-${amount.toInt().toString()}'
        : '+${amount.toInt().toString()}';
  }

  String get dateString {
    if (isSameDate(dateTime)) {
      return 'Today';
    } else if (isYesterday(dateTime)) {
      return 'Yesterday';
    }
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }

  String get categoryString {
    if (isExpense) {
      switch (expenseCatMap[category]) {
        case ExpenseCategory.entertaintment:
          return 'Entertaintment';
        case ExpenseCategory.groceries:
          return 'Groceries';
        case ExpenseCategory.home:
          return 'Home';
        case ExpenseCategory.health:
          return 'Health';
        case ExpenseCategory.food:
          return 'Food';
        case ExpenseCategory.education:
          return 'Education';
        case ExpenseCategory.travel:
          return 'Travel';
        case ExpenseCategory.others:
          return 'Others';

        default:
          return 'Invalid Category';
      }
    }

    switch (incomeCatMap[category]) {
      case IncomeCategory.salary:
        return 'Salary';
      case IncomeCategory.passive:
        return 'Passive';
      case IncomeCategory.freelancing:
        return 'Freelancing';
      case IncomeCategory.rental:
        return 'Rental';
      case IncomeCategory.others:
        return 'Others';

      default:
        return 'Invalid IncomeCategory';
    }
  }

  String get getCategoryString {
    if (isExpense) {
      switch (expenseCatMap[category]) {
        case ExpenseCategory.education:
          return 'Education';
        case ExpenseCategory.entertaintment:
          return 'Entertaintment';
        case ExpenseCategory.food:
          return 'Food';
        case ExpenseCategory.groceries:
          return 'Groceries';
        case ExpenseCategory.health:
          return 'Health';
        case ExpenseCategory.home:
          return 'Home';
        case ExpenseCategory.travel:
          return 'Travel';
        case ExpenseCategory.others:
          return 'Others';

        default:
          return 'Invalid Category';
      }
    }

    switch (incomeCatMap[category]) {
      case IncomeCategory.salary:
        return 'Salary';
      case IncomeCategory.rental:
        return 'Rental';
      case IncomeCategory.passive:
        return 'Passive';
      case IncomeCategory.freelancing:
        return 'Freelancing';
      case IncomeCategory.others:
        return 'Others';

      default:
        return 'Invalid IncomeCategory';
    }
  }

  IconData get icon {
    if (isExpense) {
      switch (expenseCatMap[category]) {
        case ExpenseCategory.education:
          return Icons.menu_book_outlined;
        case ExpenseCategory.entertaintment:
          return Icons.movie_creation_outlined;
        case ExpenseCategory.food:
          return Icons.food_bank_outlined;
        case ExpenseCategory.groceries:
          return Icons.local_grocery_store_outlined;
        case ExpenseCategory.health:
          return Icons.health_and_safety;
        case ExpenseCategory.home:
          return Icons.home_outlined;
        case ExpenseCategory.travel:
          return Icons.airplanemode_active_outlined;
        case ExpenseCategory.others:
          return Icons.question_mark_outlined;

        default:
          return Icons.dangerous_outlined;
      }
    }

    switch (incomeCatMap[category]) {
      case IncomeCategory.salary:
        return Icons.attach_money_outlined;
      case IncomeCategory.rental:
        return Icons.car_rental_outlined;
      case IncomeCategory.passive:
        return Icons.currency_bitcoin_outlined;
      case IncomeCategory.freelancing:
        return Icons.work;
      case IncomeCategory.others:
        return Icons.question_mark_outlined;

      default:
        return Icons.dangerous_outlined;
    }
  }

  IconData get categoryIcon {
    if (isExpense) {
      switch (expenseCatMap[category]) {
        case ExpenseCategory.education:
          return Icons.menu_book_outlined;
        case ExpenseCategory.entertaintment:
          return Icons.movie_creation_outlined;
        case ExpenseCategory.food:
          return Icons.food_bank_outlined;
        case ExpenseCategory.groceries:
          return Icons.local_grocery_store_outlined;
        case ExpenseCategory.health:
          return Icons.health_and_safety;
        case ExpenseCategory.home:
          return Icons.home_outlined;
        case ExpenseCategory.travel:
          return Icons.airplanemode_active_outlined;
        case ExpenseCategory.others:
          return Icons.question_mark_outlined;

        default:
          return Icons.dangerous_outlined;
      }
    }

    switch (incomeCatMap[category]) {
      case IncomeCategory.salary:
        return Icons.attach_money_outlined;
      case IncomeCategory.rental:
        return Icons.car_rental_outlined;
      case IncomeCategory.passive:
        return Icons.currency_bitcoin_outlined;
      case IncomeCategory.freelancing:
        return Icons.work;
      case IncomeCategory.others:
        return Icons.question_mark_outlined;

      default:
        return Icons.dangerous_outlined;
    }
  }

  MaterialColor get color {
    if (isExpense) {
      switch (expenseCatMap[category]) {
        case ExpenseCategory.education:
          return Colors.blue;
        case ExpenseCategory.entertaintment:
          return Colors.red;
        case ExpenseCategory.food:
          return Colors.yellow;
        case ExpenseCategory.groceries:
          return Colors.lightGreen;
        case ExpenseCategory.health:
          return Colors.green;
        case ExpenseCategory.home:
          return Colors.lightBlue;
        case ExpenseCategory.travel:
          return Colors.indigo;
        case ExpenseCategory.others:
          return Colors.grey;

        default:
          return Colors.grey;
      }
    }
    switch (incomeCatMap[category]) {
      case IncomeCategory.salary:
        return Colors.lightGreen;
      case IncomeCategory.rental:
        return Colors.brown;
      case IncomeCategory.passive:
        return Colors.amber;

      case IncomeCategory.freelancing:
        return Colors.teal;
      case IncomeCategory.others:
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  Map<int, dynamic> expenseCatMap = {
    0: ExpenseCategory.entertaintment,
    1: ExpenseCategory.groceries,
    2: ExpenseCategory.home,
    3: ExpenseCategory.health,
    4: ExpenseCategory.food,
    5: ExpenseCategory.education,
    6: ExpenseCategory.travel,
    7: ExpenseCategory.others,
  };

  Map<int, dynamic> incomeCatMap = {
    0: IncomeCategory.salary,
    1: IncomeCategory.passive,
    2: IncomeCategory.freelancing,
    3: IncomeCategory.rental,
    4: IncomeCategory.others,
  };

  // MADE THESE TWO STATIC METHODS TO FACILITATE THE ADD TRASACTION SCREEN.
  static staticGetCategoryString(bool isExpense, category) {
    if (isExpense) {
      switch (category) {
        case ExpenseCategory.education:
          return 'Education';
        case ExpenseCategory.entertaintment:
          return 'Entertaintment';
        case ExpenseCategory.food:
          return 'Food';
        case ExpenseCategory.groceries:
          return 'Groceries';
        case ExpenseCategory.health:
          return 'Health';
        case ExpenseCategory.home:
          return 'Home';
        case ExpenseCategory.travel:
          return 'Travel';
        case ExpenseCategory.others:
          return 'Others';

        default:
          return 'Invalid Category';
      }
    }

    switch (category) {
      case IncomeCategory.salary:
        return 'Salary';
      case IncomeCategory.rental:
        return 'Rental';
      case IncomeCategory.passive:
        return 'Passive';
      case IncomeCategory.freelancing:
        return 'Freelancing';
      case IncomeCategory.others:
        return 'Others';

      default:
        return 'Invalid IncomeCategory';
    }
  }

  static staticGetcategoryIcon(bool isExpense, category) {
    if (isExpense) {
      switch (category) {
        case ExpenseCategory.education:
          return Icons.menu_book_outlined;
        case ExpenseCategory.entertaintment:
          return Icons.movie_creation_outlined;
        case ExpenseCategory.food:
          return Icons.food_bank_outlined;
        case ExpenseCategory.groceries:
          return Icons.local_grocery_store_outlined;
        case ExpenseCategory.health:
          return Icons.health_and_safety;
        case ExpenseCategory.home:
          return Icons.home_outlined;
        case ExpenseCategory.travel:
          return Icons.airplanemode_active_outlined;
        case ExpenseCategory.others:
          return Icons.question_mark_outlined;

        default:
          return Icons.dangerous_outlined;
      }
    }

    switch (category) {
      case IncomeCategory.salary:
        return Icons.attach_money_outlined;
      case IncomeCategory.rental:
        return Icons.car_rental_outlined;
      case IncomeCategory.passive:
        return Icons.currency_bitcoin_outlined;
      case IncomeCategory.freelancing:
        return Icons.work;
      case IncomeCategory.others:
        return Icons.question_mark_outlined;

      default:
        return Icons.dangerous_outlined;
    }
  }
}
