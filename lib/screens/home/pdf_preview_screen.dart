import 'dart:typed_data';

import 'package:expense_tracker_v2/screens/home/make_pdf.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../model/transaction_model.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen(
      {super.key,
      required this.pieChartImage,
      required this.barChartImage,
      required this.isExpense,
      required this.transactions});
  final Uint8List pieChartImage;
  final Uint8List barChartImage;
  final bool isExpense;
  final List<AppTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => makePdf(
          barChartImage: barChartImage,
          pieChartImage: pieChartImage,
          isExpense: isExpense,
          transactions: transactions,
        ),
      ),
    );
  }
}
