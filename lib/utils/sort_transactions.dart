import 'package:expense_tracker_v2/model/transaction_model.dart';

List<AppTransaction> getFirst(
  bool isExpense,
  List<AppTransaction> transactions,
  int category,
) {
  return transactions
          .where(
            (element) =>
                element.isExpense == isExpense && element.category == category,
          )
          .toList() +
      transactions.where((element) => element.category != category).toList();
}

List<AppTransaction> filter(
  bool isExpense,
  List<AppTransaction> transactions,
  int category,
) {
  if (category > -1) {
    return transactions
        .where(
          (element) =>
              element.isExpense == isExpense && element.category == category,
        )
        .toList();
  }
  return transactions;
}
