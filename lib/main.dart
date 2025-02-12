import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfTextExtractorScreen(),
    );
  }
}

class PdfTextExtractorScreen extends StatefulWidget {
  @override
  _PdfTextExtractorScreenState createState() => _PdfTextExtractorScreenState();
}

class _PdfTextExtractorScreenState extends State<PdfTextExtractorScreen> {
  String extractedText = "Select a PDF to extract text.";

  Future<void> pickAndExtractText() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      File file = File(filePath);

      try {
        // Load the PDF document
        final PdfDocument pdfDoc =
            PdfDocument(inputBytes: file.readAsBytesSync());

        // Extract text from all pages
        String text = "";
        for (int i = 0; i < pdfDoc.pages.count; i++) {
          PdfTextExtractor extractor = PdfTextExtractor(pdfDoc);
          text += "${extractor.extractText()}\n\n"; // Extract text per page
        }

        setState(() {
          extractedText = text.isNotEmpty ? text : "No text found in PDF.";
        });

        // Dispose of the document
        pdfDoc.dispose();
      } catch (e) {
        setState(() {
          extractedText = "Error reading PDF: $e";
        });
      }
    } else {
      setState(() {
        extractedText = "No file selected.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("julliana")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickAndExtractText,
              child: Text("Pick PDF"),
            ),
            SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: Text(extractedText))),
          ],
        ),
      ),
    );
  }
}
