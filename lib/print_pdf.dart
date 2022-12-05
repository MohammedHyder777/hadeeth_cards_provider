// Pdf Imports //
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

/// Print cards in a pdf file
Future<void> printPdf(List mylist) async {
  // The content of the pdf file: //////////////////////////////////////////////
  String text = 'بسم الله الرحمن الرحيم\n';

  for (var h in mylist) {
    text += 'عن ${h.rawi} عن النبي ﷺ قال:\n'
        '(( ${h.hadeeth} )).\n'
        '${h.degree}\n ********* \n';
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
  // The path work and file saving: ////////////////////////////////////////////
  // Get the app directory:
  // Directory? exStorageDirectory = await getExternalStorageDirectory();
  // print(exStorageDirectory!.path); // /storage/emulated/0/Android/data/com.example.hadeeth_cards_provider/files

  // Check if I have permission to store:
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  // Check again because the user may refuse:
  if (!status.isGranted) {
    throw const FileSystemException('Permission denied! cannot access storage.');
  }
  // Save the file:
  final file = File('/storage/emulated/0/Download/hadeethtest.pdf');
  await file.writeAsBytes(await pdf.save());
}

/// Show an alert about the success or failure of print pdf
void showPrintPdfSuccess(context, bool failure) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                failure ? Icons.error : Icons.check_circle,
                color: failure ? Colors.red : Colors.green,
                size: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                failure ? 'لم يتيسر طباعة بطاقاتك' : 'نجحت طباعة بطاقاتك في ملف pdf.',
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
