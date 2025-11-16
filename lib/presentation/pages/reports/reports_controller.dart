import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReportsController {
  DateTime? selectedDate;
  String? selectedMonth;
  String? selectedYear;

  final List<Map<String, dynamic>> _rawDesignerData = [
    {
      "name": "Aldo",
      "designs": [
        {"title": "Logo Brand A", "date": DateTime(2024, 5, 10)},
        {"title": "Poster Event B", "date": DateTime(2024, 6, 3)},
        {"title": "Banner C", "date": DateTime(2024, 6, 20)},
      ],
    },
    {
      "name": "Bima",
      "designs": [
        {"title": "Desain UI Dashboard", "date": DateTime(2024, 4, 1)},
        {"title": "Flyer Produk X", "date": DateTime(2024, 6, 2)},
      ],
    },
    {
      "name": "Citra",
      "designs": [
        {"title": "Packaging Minuman Z", "date": DateTime(2023, 12, 20)},
        {"title": "Logo Startup M", "date": DateTime(2024, 1, 15)},
        {"title": "Social Media Kit", "date": DateTime(2024, 6, 5)},
        {"title": "Mockup Website", "date": DateTime(2024, 6, 21)},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredDesignerData {
    return _rawDesignerData.map((designer) {
      final List<Map<String, dynamic>> designs =
          (designer['designs'] as List<dynamic>).cast<Map<String, dynamic>>();

      final filtered = designs.where((d) {
        final DateTime date = d['date'] as DateTime;

        if (selectedDate != null) {
          return date.year == selectedDate!.year &&
              date.month == selectedDate!.month &&
              date.day == selectedDate!.day;
        }

        if (selectedYear != null) {
          final int y = int.parse(selectedYear!);
          if (date.year != y) return false;

          if (selectedMonth != null) {
            final monthIndex =
                DateFormat('MMMM').parse(selectedMonth!).month;
            return date.month == monthIndex;
          }

          return true;
        }

        if (selectedMonth != null) {
          final monthIndex =
              DateFormat('MMMM').parse(selectedMonth!).month;
          return date.month == monthIndex;
        }

        return true;
      }).toList();

      return {"name": designer['name'], "designs": filtered};
    }).where((designer) {
      final List designs = designer['designs'] as List;
      return designs.isNotEmpty;
    }).toList();
  }

  int get totalCompleted {
    return filteredDesignerData.fold(
        0, (sum, d) => sum + (d['designs'] as List).length);
  }

  String get filterSummary {
    if (selectedDate != null) {
      return DateFormat('dd MMM yyyy').format(selectedDate!);
    } else if (selectedYear != null && selectedMonth != null) {
      return "$selectedMonth $selectedYear";
    } else if (selectedYear != null) {
      return selectedYear!;
    } else if (selectedMonth != null) {
      return selectedMonth!;
    }
    return "Semua waktu";
  }

  Future<void> exportToPdf() async {
    final pdf = pw.Document();
    final df = DateFormat('dd MMM yyyy');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          final rows = filteredDesignerData.map((designer) {
            final name = designer['name'] as String;
            final designs = (designer['designs'] as List)
                .map((d) =>
                    "${d['title']} (${df.format(d['date'] as DateTime)})")
                .join("\n");
            final count = (designer['designs'] as List).length.toString();
            return [name, count, designs];
          }).toList();

          return [
            pw.Text('Laporan Desain Selesai',
                style: pw.TextStyle(
                    fontSize: 22, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 6),
            pw.Text('Filter: $filterSummary',
                style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 10),
            pw.TableHelper.fromTextArray(
              headers: ['Nama Desainer', 'Jumlah', 'Desain (judul + tanggal)'],
              data: rows,
              headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.teal),
              cellAlignment: pw.Alignment.topLeft,
            ),
            pw.SizedBox(height: 12),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('Total: $totalCompleted desain',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold)),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
