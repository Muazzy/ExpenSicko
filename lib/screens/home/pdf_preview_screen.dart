import 'dart:typed_data';

import 'package:expense_tracker_v2/screens/home/make_pdf.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen(
      {super.key, required this.pieChartImage, required this.barChartImage});
  final Uint8List pieChartImage;
  final Uint8List barChartImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) =>
            makePdf(barChartImage: barChartImage, pieChartImage: pieChartImage),
      ),
    );
  }
}
