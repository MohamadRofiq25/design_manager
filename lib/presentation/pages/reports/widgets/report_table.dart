import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../reports_controller.dart';

class ReportTable extends StatelessWidget {
  final ReportsController controller;
  const ReportTable({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final data = controller.filteredDesignerData;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF45D1A6),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Text(
              'Statistik Desain Selesai',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nama Desainer')),
                  DataColumn(label: Text('Jumlah Desain')),
                  DataColumn(label: Text('Desain yang Dibuat')),
                  DataColumn(label: Text('Tanggal Selesai')),
                ],
                rows: data.map((item) {
                  final List designs = item['designs'] as List;
                  final titles = designs.map((d) => d['title']).join(", ");
                  final dates = designs
                      .map((d) =>
                          DateFormat('dd/MM/yyyy').format(d['date'] as DateTime))
                      .join(", ");
                  return DataRow(cells: [
                    DataCell(Text(item['name'])),
                    DataCell(Text(designs.length.toString())),
                    DataCell(SizedBox(
                      width: 250,
                      child: Text(titles,
                          overflow: TextOverflow.ellipsis, maxLines: 2),
                    )),
                    DataCell(SizedBox(
                      width: 200,
                      child: Text(dates,
                          overflow: TextOverflow.ellipsis, maxLines: 2),
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: ${controller.totalCompleted} desain',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
