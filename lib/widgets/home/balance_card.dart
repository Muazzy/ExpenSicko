import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/res/textstyles.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key? key,
    required this.balance,
    required this.expenses,
    required this.incomes,
  }) : super(key: key);

  final double balance;
  final double expenses;
  final double incomes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.075),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(-0.8, -0.8),
            stops: const [0.0, 0.5, 0.5, 1],
            colors: [
              AppColors.darkPurple.withOpacity(1),
              AppColors.darkPurple.withOpacity(1),
              AppColors.darkPurple.withOpacity(0.8),
              AppColors.darkPurple.withOpacity(0.95),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.3,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: balance.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 2.0),
                            blurRadius: 3.0,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ],
                      ),
                    ),
                    const TextSpan(
                      text: 'PKR',
                      style: TextStyle(
                        color: AppColors.darkPink,
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                        ],
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: const Alignment(0.8, 0.15),
                      stops: const [0.0, 0.5, 0.5, 1],
                      colors: [
                        AppColors.darkPurple.withOpacity(0.5),
                        AppColors.darkPurple.withOpacity(0.5),
                        AppColors.darkPurple.withOpacity(0.3),
                        AppColors.darkPurple.withOpacity(0.45),
                      ],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.green.shade700,
                                  size: 14,
                                ),
                                const Text(
                                  'Income',
                                  style: kExpenseHeadingTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              incomes.toString(),
                              style: kExpenseBodyTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red.shade700,
                                  size: 14,
                                ),
                                const Text(
                                  'Expense',
                                  style: kExpenseHeadingTextStyle,
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              expenses.toString(),
                              style: kExpenseBodyTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
