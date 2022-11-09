import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:expense_tracker_v2/model/transaction_model.dart';
import 'package:expense_tracker_v2/services/data_repository.dart';
import 'package:expense_tracker_v2/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  bool isExpense = true;
  int selectedCategory = 0;
  DateTime selectedDate = DateTime.now();
  TextEditingController transactionNameController =
      TextEditingController(text: 'untitled');
  TextEditingController transactionAmountController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    List expenses = ExpenseCategory.values;
    List incomes = IncomeCategory.values;

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000, 12),
          lastDate: DateTime(2114));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          print(selectedDate);
        });
      }
    }

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: bodyTextColor,
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
                      color: bodyTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    'Income',
                    style: TextStyle(
                      color: bodyTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            IconButton(
              onPressed: () {
                setState(() {
                  isExpense = !isExpense;
                  selectedCategory = 0;
                });
              },
              icon: const Icon(
                Icons.currency_exchange_outlined,
                color: darkPink,
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<DataRepositroy>()
                    .addTransaction(
                      transactionNameController.text,
                      double.parse(transactionAmountController.text),
                      selectedDate,
                      isExpense,
                      selectedCategory,
                      context,
                    )
                    .whenComplete(() => Navigator.pop(context));
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(3),
                backgroundColor: MaterialStateProperty.all(darkPurple),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                ),
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: white,
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
                              ? darkPurple.withOpacity(0.3)
                              : white,
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
                                color: darkPurple,
                              ),
                              Text(
                                AppTransaction.staticGetCategoryString(
                                  isExpense,
                                  isExpense ? expenses[index] : incomes[index],
                                ),
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: darkPurple,
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
                      color: darkPurple,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(
                      Icons.calendar_month,
                      color: darkPink,
                    ),
                  ),
                ],
              ),
            ),
            // Divider(
            //   color: darkPink.withOpacity(0.5),
            // ),
            const SizedBox(height: 10),
            Form(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    darkPurple.withOpacity(0.8),
                    darkPurple,
                  ]),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: transactionNameController,
                          // initialValue: 'untitled',
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: white.withOpacity(0.6),
                            ),
                            // contentPadding: EdgeInsets.symmetric(),
                            icon: Icon(
                              AppTransaction.staticGetcategoryIcon(
                                isExpense,
                                isExpense
                                    ? expenses[selectedCategory]
                                    : incomes[selectedCategory],
                              ),
                              color: white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Name',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: transactionAmountController,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: white,
                            fontSize: 24,
                          ),
                          keyboardType: TextInputType.number,
                          // initialValue: '0',
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: white.withOpacity(0.6),
                            ),
                            border: InputBorder.none,
                            hintText: 'Amount',
                          ),
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
