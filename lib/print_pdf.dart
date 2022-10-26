// Pdf Imports //
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Print cards in a pdf file
void printPdf(List mylist) async {
  String text = 'بسم الله الرحمن الرحيم\n';

  for (var h in mylist) {
    text +=
        'عن ${h.rawi} عن النبي ﷺ قال:\n' '(( ${h.hadeeth} )).\n' '${h.degree}\n';
  }
  final pdf = pw.Document();
  final font = await rootBundle.load('assets/fonts/Traditional Arabic.ttf');
  final myttf = pw.Font.ttf(font);
  pw.Page page = pw.Page(
    textDirection: pw.TextDirection.rtl,
    pageFormat: PdfPageFormat.a4,
    build: (context) {
      return pw.Align(
        alignment: pw.Alignment.topRight,
        child: pw.Text(text,
            textDirection: pw.TextDirection.rtl,
            // ignore: prefer_const_constructors
            style: pw.TextStyle(fontSize: 17, font: myttf)),
      );
    },
  );
  pdf.addPage(page);
  final file = File('test.pdf');
  await file.writeAsBytes(await pdf.save());
}

/// Show an alert about the success or failure of print pdf
void showPrintPdfSuccess(context, String messageText) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                messageText,
                style: const TextStyle(
                  fontFamily: 'Scheherazade New',
                  fontSize: 18,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        );
      });
}
