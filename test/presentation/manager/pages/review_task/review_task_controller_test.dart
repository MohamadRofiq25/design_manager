import 'package:flutter_test/flutter_test.dart';
import 'package:design_manager/presentation/manager/pages/review_task/review_task_controller.dart';
import 'package:design_manager/data/models/task_model.dart';

void main() {
  late ReviewTaskController controller;

  setUp(() {
    controller = ReviewTaskController();
  });

  group('ReviewTaskController - Initial State', () {
    test('memiliki 2 task dengan status proof', () {
      expect(controller.proofTasks.length, 2);
    });

    test('task pertama memiliki title yang benar', () {
      expect(controller.proofTasks.first.title, 'Poster Feminine Care Spray');
    });
  });

  group('updateTask()', () {
    test('update task yang ada berdasarkan ID', () {
      final updated = Task(
        id: '1',
        title: 'Poster Updated Version',
        designerName: 'Mohamad Rofiqul Abror',
        description: 'Poster updated description',
        imagePath: 'assets/images/sample_design_1.png',
        status: 'revision',
      );

      controller.updateTask(updated);

      final firstTask = controller.proofTasks.first;
      expect(firstTask.title, 'Poster Updated Version');
      expect(firstTask.status, 'revision');
    });

    test('tidak mengubah task jika ID tidak ditemukan', () {
      final updated = Task(
        id: '999',
        title: 'Invalid Update',
        designerName: 'Unknown',
        description: 'Invalid',
        imagePath: 'assets/images/sample_design_1.png',
        status: 'proof',
      );

      controller.updateTask(updated);

      // Tetap 2 task (tidak ada perubahan)
      expect(controller.proofTasks.length, 2);

      // Pastikan task pertama tetap tidak berubah
      expect(controller.proofTasks.first.title, 'Poster Feminine Care Spray');
    });

    test('notifyListeners() terpanggil setelah update valid', () {
      int notifyCount = 0;

      controller.addListener(() {
        notifyCount++;
      });

      final updated = Task(
        id: '1',
        title: 'New Title',
        designerName: 'Mohamad Rofiqul Abror',
        description: 'desc',
        imagePath: 'assets/images/sample_design_1.png',
        status: 'proof',
      );

      controller.updateTask(updated);

      expect(notifyCount, 1);
    });

    test('notifyListeners() tidak terpanggil jika update gagal (ID tidak ditemukan)', () {
      int notifyCount = 0;

      controller.addListener(() {
        notifyCount++;
      });

      final updated = Task(
        id: '999',
        title: 'Invalid',
        designerName: 'X',
        description: 'Y',
        imagePath: 'assets/images/sample_design_1.png',
        status: 'proof',
      );

      controller.updateTask(updated);

      expect(notifyCount, 0);
    });
  });
}
