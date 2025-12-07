import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../reports_controller.dart';

class FilterSection extends StatefulWidget {
  final ReportsController controller;
  const FilterSection({super.key, required this.controller});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  @override
  Widget build(BuildContext context) {
    final years = List.generate(6, (i) => (2020 + i).toString());
    final months = List.generate(
        12, (i) => DateFormat('MMMM').format(DateTime(0, i + 1)));

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter Laporan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Tahun"),
                    initialValue: widget.controller.selectedYear,
                    items: years
                        .map((year) =>
                            DropdownMenuItem(value: year, child: Text(year)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      widget.controller.selectedYear = value;
                      widget.controller.selectedDate = null;
                    }),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Bulan"),
                    initialValue: widget.controller.selectedMonth,
                    items: months
                        .map((month) =>
                            DropdownMenuItem(value: month, child: Text(month)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      widget.controller.selectedMonth = value;
                      widget.controller.selectedDate = null;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate:
                          widget.controller.selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        widget.controller.selectedDate = picked;
                        widget.controller.selectedYear = null;
                        widget.controller.selectedMonth = null;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(widget.controller.selectedDate == null
                      ? "Pilih Tanggal"
                      : DateFormat('dd MMM yyyy')
                          .format(widget.controller.selectedDate!)),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () => setState(() {
                    widget.controller.selectedDate = null;
                    widget.controller.selectedMonth = null;
                    widget.controller.selectedYear = null;
                  }),
                  icon: const Icon(Icons.clear),
                  label: const Text('Reset Filter'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Menampilkan: ${widget.controller.filterSummary}',
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
