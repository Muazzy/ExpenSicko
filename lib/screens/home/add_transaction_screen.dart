// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/constants/content.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/services/data_repository.dart';
import 'package:expense_tracker_v2/utils/custom_snackbar.dart';
import 'package:expense_tracker_v2/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({
    Key? key,
    AppTransaction? transaction,
    this.isUpdate = false,
  })  : transaction = transaction ??
            AppTransaction(
              dateTime: DateTime.now(),
              null,
              amount: 0,
              name: 'untitled',
              category: 0,
              isExpense: true,
            ),
        super(key: key);

  final AppTransaction transaction;
  final bool isUpdate;

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  late DateTime selectedDate;
  late TextEditingController transactionNameController;
  late TextEditingController transactionAmountController;
  bool isExpense = true;
  int selectedCategory = 0;
  @override
  void dispose() {
    // dispose it here
    transactionNameController.dispose();
    transactionAmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedCategory = widget.transaction.category;
    selectedDate = widget.transaction.dateTime;

    transactionAmountController = TextEditingController(
      text: widget.transaction.amount.toInt().toString(),
    );
    transactionNameController = TextEditingController(
      text: widget.transaction.name,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List expenses = ExpenseCategory.values;
    List incomes = IncomeCategory.values;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000, 12),
          lastDate: DateTime(2114));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          // print(selectedDate);
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.bodyTextColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            isExpense
                ? const Text(
                    'Expense',
                    style: TextStyle(
                      color: AppColors.bodyTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    'Income',
                    style: TextStyle(
                      color: AppColors.bodyTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            Hero(
              tag: fabHeroTag,
              transitionOnUserGestures: true,
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isExpense = !isExpense;
                      selectedCategory = 0;
                    });
                  },
                  icon: const Icon(
                    Icons.currency_exchange_outlined,
                    color: AppColors.darkPink,
                  ),
                ),
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            child: ElevatedButton(
              onPressed: widget.isUpdate
                  ? () async {
                      await widget.transaction
                          .updateWith(
                            amount: double.tryParse(
                                transactionAmountController.text),
                            category: selectedCategory,
                            dataTime: selectedDate,
                            isExpense: isExpense,
                            name: transactionNameController.text,
                          )
                          .onError(
                            (error, stackTrace) => showSnackBar(
                              context,
                              error.toString(),
                            ),
                          )
                          .whenComplete(() {
                        showSnackBar(context, 'updated');
                        Navigator.pop(context);
                      });
                    }
                  : () {
                      context
                          .read<DataRepository>()
                          .addTransaction(
                            transactionNameController.text.isEmpty
                                ? 'untitled'
                                : transactionNameController.text,
                            transactionAmountController.text.isEmpty
                                ? 0
                                : double.parse(
                                    transactionAmountController.text),
                            selectedDate,
                            isExpense,
                            selectedCategory,
                            context,
                          )
                          .whenComplete(() => Navigator.pop(context));
                    },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(3),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.darkPurple),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                ),
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              child: widget.isUpdate
                  ? const Text(
                      'Update',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: isExpense ? expenses.length : incomes.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                      // print(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCategory == index
                              ? AppColors.darkPurple.withOpacity(0.3)
                              : AppColors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                AppTransaction.staticGetcategoryIcon(
                                  isExpense,
                                  isExpense ? expenses[index] : incomes[index],
                                ),
                                color: AppColors.darkPurple,
                              ),
                              Text(
                                AppTransaction.staticGetCategoryString(
                                  isExpense,
                                  isExpense ? expenses[index] : incomes[index],
                                ),
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.darkPurple,
                                  fontSize: 12,
                                  fontWeight: selectedCategory == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.all(16),
              ),
            ),
            // Divider(
            //   color: darkPink.withOpacity(0.5),
            // ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isSameDay(selectedDate, DateTime.now())
                        ? 'Today'
                        : formatDate(selectedDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkPurple,
                    ),
                  ),
                  IconButton(
                    onPressed: () => selectDate(context),
                    icon: const Icon(
                      Icons.calendar_month,
                      color: AppColors.darkPink,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Form(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.darkPurple.withOpacity(0.8),
                    AppColors.darkPurple,
                  ]),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          onTap: () {
                            transactionNameController.clear();
                          },
                          controller: transactionNameController,
                          // initialValue: 'untitled',
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: AppColors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColors.white.withOpacity(0.6),
                            ),
                            // contentPadding: EdgeInsets.symmetric(),
                            icon: Icon(
                              AppTransaction.staticGetcategoryIcon(
                                isExpense,
                                isExpense
                                    ? expenses[selectedCategory]
                                    : incomes[selectedCategory],
                              ),
                              color: AppColors.white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Name',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: transactionAmountController,
                          onTap: () {
                            transactionAmountController.clear();
                          },
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            fontSize: 24,
                          ),
                          keyboardType: TextInputType.number,
                          // initialValue: '0',
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.white.withOpacity(0.6),
                            ),
                            border: InputBorder.none,
                            hintText: 'Amount',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
