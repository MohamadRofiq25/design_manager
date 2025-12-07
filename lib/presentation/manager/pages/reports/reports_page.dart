import 'package:flutter/material.dart';
import 'reports_controller.dart';
import 'widgets/filter_section.dart';
import 'widgets/report_table.dart';
import 'widgets/export_button.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late ReportsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ReportsController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: const Color(0xFF45D1A6),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FilterSection(controller: _controller),
            ReportTable(controller: _controller),
            ExportButton(controller: _controller),
          ],
        ),
      ),
    );
  }
}
