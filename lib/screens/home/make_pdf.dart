import 'dart:typed_data';

import 'package:expense_tracker_v2/res/content.dart';
import 'package:expense_tracker_v2/utils/transaction_conversions.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../model/transaction_model.dart';

Future<Uint8List> makePdf({
  required Uint8List pieChartImage,
  required Uint8List barChartImage,
  required bool isExpense,
  required List<AppTransaction> transactions,
}) async {
  final pdf = Document();
  final pieChart = MemoryImage(pieChartImage);
  final barChart = MemoryImage(barChartImage);

  final now = DateTime.now();
  final month = months[now.month - 1].toUpperCase().substring(0, 3);
  final thisMonthsTransactions = transactions
      .where((element) => element.dateTime.month == now.month)
      .toList();
  final double totalExpense =
      addAllTransactionAmount(true, thisMonthsTransactions);
  final double totalIncome =
      addAllTransactionAmount(false, thisMonthsTransactions);
  final double balance = totalIncome - totalExpense;

  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Monthly Report ($month ${now.year})',
                style: Theme.of(context).header1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 1,
              borderStyle: BorderStyle.solid,
            ),
            Spacer(),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    customText('Total Income'),
                    customText(
                      '$totalIncome',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    customText(
                      'Total Expense',
                    ),
                    customText(
                      '$totalExpense',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    customText(
                      'Balance',
                    ),
                    customText(
                      '$balance',
                      color:
                          balance.isNegative ? PdfColors.red : PdfColors.green,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    isExpense ? 'Expense Stats' : 'Income Stats',
                    style: Theme.of(context).header1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 190,
                  width: 190,
                  child: Image(pieChart),
                ),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Image(barChart),
                ),
              ],
            ),
            Spacer(),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Generated with ExpenSicko',
                style: Theme.of(context).header5.copyWith(
                      color: const PdfColor.fromInt(0xff6A68D0),
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget customText(
  final String text, {
  final TextAlign align = TextAlign.left,
  final PdfColor color = PdfColors.black,
  final FontWeight fontWeight = FontWeight.normal,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
        style: TextStyle.defaultStyle()
            .copyWith(color: color, fontWeight: fontWeight),
      ),
    );
