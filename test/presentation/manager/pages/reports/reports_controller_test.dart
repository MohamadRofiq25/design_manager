import 'package:flutter_test/flutter_test.dart';
import 'package:design_manager/presentation/manager/pages/reports/reports_controller.dart';
import 'package:intl/intl.dart';

void main() {
  late ReportsController controller;

  setUp(() {
    controller = ReportsController();
  });

  group('Initial State', () {
    test('initial filter is null and summary = "Semua waktu"', () {
      expect(controller.selectedDate, null);
      expect(controller.selectedMonth, null);
      expect(controller.selectedYear, null);
      expect(controller.filterSummary, 'Semua waktu');
    });

    test('initial filtered data should return all designers with non-empty designs', () {
      final filtered = controller.filteredDesignerData;
      expect(filtered.length, 3);
    });

    test('initial totalCompleted is total all designs across designers', () {
      final total = controller.totalCompleted;
      expect(total, 9); // 3 + 2 + 4
    });
  });

  group('setDate()', () {
    test('setDate should update selectedDate and clear month/year', () {
      final date = DateTime(2024, 6, 3);
      controller.setDate(date);

      expect(controller.selectedDate, date);
      expect(controller.selectedMonth, null);
      expect(controller.selectedYear, null);
      expect(controller.filterSummary, DateFormat('dd MMM yyyy').format(date));
    });

    test('setDate triggers notifyListeners', () {
      int count = 0;
      controller.addListener(() => count++);

      controller.setDate(DateTime(2024, 5, 10));

      expect(count, 1);
    });

    test('filteredDesignerData - filtering by exact date', () {
      controller.setDate(DateTime(2024, 6, 3));

      final filtered = controller.filteredDesignerData;

      // Hanya Aldo yang punya desain di 3 Juni 2024
      expect(filtered.length, 1);
      expect(filtered.first['name'], 'Aldo');
      expect((filtered.first['designs'] as List).length, 1);
    });
  });

  group('setMonth()', () {
    test('setMonth should set selectedMonth and clear selectedDate', () {
      controller.setMonth('June');

      expect(controller.selectedMonth, 'June');
      expect(controller.selectedDate, null);
      expect(controller.filterSummary, 'June');
    });

    test('setMonth triggers notifyListeners', () {
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      controller.setMonth('June');

      expect(notifyCount, 1);
    });

    test('filteredDesignerData should filter by month only', () {
      controller.setMonth('June');

      final filtered = controller.filteredDesignerData;

      expect(filtered.length, 3);

      final aldo = filtered.firstWhere((d) => d['name'] == 'Aldo');
      expect((aldo['designs'] as List).length, 2); // 6/3 & 6/20

      final bima = filtered.firstWhere((d) => d['name'] == 'Bima');
      expect((bima['designs'] as List).length, 1); // 6/2

      final citra = filtered.firstWhere((d) => d['name'] == 'Citra');
      expect((citra['designs'] as List).length, 2); // 6/5 & 6/21
    });
  });

  group('setYear()', () {
    test('setYear should set selectedYear and clear selectedDate', () {
      controller.setYear('2024');

      expect(controller.selectedYear, '2024');
      expect(controller.selectedDate, null);
      expect(controller.filterSummary, '2024');
    });

    test('setYear triggers notifyListeners', () {
      int count = 0;
      controller.addListener(() => count++);

      controller.setYear('2024');

      expect(count, 1);
    });

    test('filteredDesignerData should filter by year only', () {
      controller.setYear('2024');

      final filtered = controller.filteredDesignerData;

      // Semua desain pada tahun 2024
      expect(filtered.length, 3);

      final aldo = filtered.firstWhere((d) => d['name'] == 'Aldo');
      expect((aldo['designs'] as List).length, 3);

      final bima = filtered.firstWhere((d) => d['name'] == 'Bima');
      expect((bima['designs'] as List).length, 2);

      final citra = filtered.firstWhere((d) => d['name'] == 'Citra');
      expect((citra['designs'] as List).length, 3);
    });
  });

  group('setMonth + setYear combination', () {
    test('filter by month AND year', () {
      controller.setYear('2024');
      controller.setMonth('June');

      final filtered = controller.filteredDesignerData;

      expect(filtered.length, 3);

      final aldoDesigns = filtered.firstWhere((d) => d['name'] == 'Aldo')['designs'] as List;
      expect(aldoDesigns.length, 2); // 6/3 & 6/20

      final bimaDesigns = filtered.firstWhere((d) => d['name'] == 'Bima')['designs'] as List;
      expect(bimaDesigns.length, 1); // 6/2

      final citraDesigns = filtered.firstWhere((d) => d['name'] == 'Citra')['designs'] as List;
      expect(citraDesigns.length, 2); // 6/5 & 6/21

      expect(controller.filterSummary, 'June 2024');
    });
  });

  group('totalCompleted recalculation', () {
    test('totalCompleted updates after applying month filter', () {
      controller.setMonth('June');

      expect(controller.totalCompleted, 5);
      // Aldo: 2, Bima:1, Citra:2
    });

    test('totalCompleted updates after applying year filter', () {
      controller.setYear('2024');

      expect(controller.totalCompleted, 8);
      // Aldo:3, Bima:2, Citra:3
    });
  });
}
