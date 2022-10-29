import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_v2/constants/content.dart';
import 'package:flutter/material.dart';

class Expense {
  final double amount;
  final String name;
  final DateTime dateTime;
  final DocumentReference? _document;
  final ExpenseCategory category;
  final bool isExpense;

  Expense(this.amount, this.name, this.dateTime, this._document, this.category,
      {this.isExpense = true});

  Expense._fromMap(Map<String, dynamic> data, this._document, this.isExpense)
      : amount = data['amount'] ?? 0,
        name = data['name'] ?? '',
        dateTime = data['dateTime'] ?? DateTime.now(),
        category = data['category'] ?? 'others';

  Expense.fromDocument(DocumentSnapshot documentSnapshot)
      : this._fromMap(
          documentSnapshot.data() as Map<String, dynamic>,
          documentSnapshot.reference,
          false,
        );
  String get id => _document!.id;

  String get dateTimeString => dateTime.toString();
  Future<void> delete() => _document!.delete();

  Future<void> updateWith({
    double? amount,
    String? name,
    String? category,
    DateTime? dataTime,
  }) {
    return _document!.update({
      if (amount != null) 'amount': amount,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      'dateTime': dateTime,
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

  IconData get icon {
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
        return Icons.airline_seat_individual_suite_outlined;
    }
  }

  MaterialColor get color {
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
}

enum ExpenseCategory {
  entertaintment,
  groceries,
  home,
  health,
  food,
  education,
  travel,
  others
}

final now = DateTime.now();

final yesterday = DateTime(now.year, now.month, now.day - 1);
bool isSameDate(DateTime date) =>
    date.year == now.year && date.month == now.month && date.day == now.day;

bool isYesterday(DateTime date) =>
    date.year == yesterday.year &&
    date.month == yesterday.month &&
    date.day == yesterday.day;
