import 'package:flutter/material.dart';
import '../reports_controller.dart';

class ExportButton extends StatelessWidget {
  final ReportsController controller;
  const ExportButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton.icon(
        onPressed: controller.exportToPdf,
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text('Ekspor ke PDF'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF45D1A6),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
