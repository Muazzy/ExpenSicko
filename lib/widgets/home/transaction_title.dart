import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/constants/textstyles.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/screens/add_transaction_screen.dart';
import 'package:expense_tracker_v2/utils/custom_snackbar.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/custom_dialog.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final AppTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: darkPurple,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.edit,
            color: white,
          ),
        ),
      ),
      secondaryBackground: Container(
        color: darkPink,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: white,
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.endToStart:
            return await _openDeleteConfirmation(context);
          case DismissDirection.startToEnd:
            await _openUpdateDialog(context);
            break;
          default:
            print('Unhandled dismiss of an ExpenseListTile: $direction');
            break;
        }
        return false;
      },
      // onDismissed: (_) => transaction.delete(),
      key: ValueKey(transaction.docId),
      child: ListTile(
        onLongPress: () {},
        isThreeLine: false,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          decoration: BoxDecoration(
            color: transaction.color.shade100,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              transaction.icon,
              size: 32,
              color: transaction.color.shade900,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transaction.name,
              style: kTitleTextStyle,
            ),
            Text(
              transaction.amountString,
              style: kTitleTextStyle,
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transaction.categoryString,
              style: kSubtitleTextStyle,
            ),
            Text(
              transaction.dateString,
              style: kSubtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _openDeleteConfirmation(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          dialogHeading: 'Delete',
          dialogBody: 'Delete ${transaction.name}?',
          actionFunction: () async {
            await transaction
                .delete()
                .onError(
                  (error, stackTrace) => showSnackBar(
                    context,
                    error.toString(),
                  ),
                )
                .whenComplete(() {
              Navigator.pop(context, true);
              showSnackBar(context, 'Deleted  ${transaction.name}');
            });
          },
          actionButtonText: 'Delete',
        );
      },
    );
  }

  _openUpdateDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomDialog(
          dialogHeading: 'Update',
          dialogBody: 'Update ${transaction.name}?',
          actionFunction: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddTransaction(
                    isUpdate: true,
                    transaction: transaction,
                  );
                },
              ),
            );
          },
          actionButtonText: 'Update',
        );
      },
    );
  }
}
