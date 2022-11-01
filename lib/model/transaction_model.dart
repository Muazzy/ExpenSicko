import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/constants/content.dart';
import 'package:flutter/material.dart';

class AppTransaction {
  final double amount;
  final String name;
  final DateTime dateTime;
  final DocumentReference? document;
  final category;
  final bool isExpense;

  AppTransaction({
    required this.amount,
    required this.name,
    required this.dateTime,
    required this.document,
    required this.category,
    required this.isExpense,
  });

  AppTransaction._fromMap(
    Map<String, dynamic> data,
    this.document,
  )   : amount = data['amount'] ?? 0,
        name = data['name'] ?? '',
        dateTime = data['dateTime'] ?? DateTime.now(),
        category = data['category'] ?? 'others',
        isExpense = data['isExpense'] ?? true;

  AppTransaction.fromDocument(DocumentSnapshot documentSnapshot)
      : this._fromMap(
          documentSnapshot.data() as Map<String, dynamic>,
          documentSnapshot.reference,
        );
  String get id => document!.id;

  String get dateTimeString => dateTime.toString();
  Future<void> delete() => document!.delete();

  Future<void> updateWith({
    double? amount,
    String? name,
    String? category,
    DateTime? dataTime,
    bool? isExpense,
  }) {
    return document!.update({
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

  IconData get icon {
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

  MaterialColor get color {
    if (isExpense) {
      switch (category) {
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
    switch (category) {
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
}

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

final now = DateTime.now();

final yesterday = DateTime(now.year, now.month, now.day - 1);
bool isSameDate(DateTime date) =>
    date.year == now.year && date.month == now.month && date.day == now.day;

bool isYesterday(DateTime date) =>
    date.year == yesterday.year &&
    date.month == yesterday.month &&
    date.day == yesterday.day;
