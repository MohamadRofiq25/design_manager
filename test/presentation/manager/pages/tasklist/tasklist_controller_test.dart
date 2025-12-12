import 'package:flutter_test/flutter_test.dart';
import 'package:design_manager/presentation/manager/pages/tasklist/tasklist_controller.dart';
import 'package:design_manager/data/models/task_model.dart';

void main() {
  late TasklistController controller;

  setUp(() {
    controller = TasklistController();
  });

  group('TasklistController - Initial State', () {
    test('memiliki 3 task default', () {
      expect(controller.tasks.length, 3);
    });

    test('task pertama memiliki title yang benar', () {
      expect(controller.tasks.first.title, 'Product Banner Design');
    });
  });

  group('filterByStatus()', () {
    test('mengembalikan semua task ketika status = all', () {
      final result = controller.filterByStatus('all');
      expect(result.length, 3);
    });

    test('mengembalikan task dengan status pending', () {
      final result = controller.filterByStatus('pending');
      expect(result.length, 1);
      expect(result.first.status, 'pending');
    });

    test('mengembalikan task dengan status revision', () {
      final result = controller.filterByStatus('revision');
      expect(result.length, 1);
      expect(result.first.status, 'revision');
    });
  });

  group('addTask()', () {
    test('menambahkan task baru ke daftar', () {
      final newTask = Task(
        id: '10',
        title: 'New Banner',
        designerName: 'Budi',
        description: 'Deskripsi sample',
        imagePath: 'assets/images/login.png',
        status: 'pending',
      );

      controller.addTask(newTask);

      expect(controller.tasks.length, 4);
      expect(controller.tasks.last.title, 'New Banner');
    });
  });

  group('updateTask()', () {
    test('mengubah task yang ada berdasarkan ID', () {
      final updated = Task(
        id: '1',
        title: 'Updated Banner',
        designerName: 'Sarah',
        description: 'Updated description',
        imagePath: 'assets/images/login.png',
        status: 'proof',
      );

      controller.updateTask(updated);

      final firstTask = controller.tasks.first;
      expect(firstTask.title, 'Updated Banner');
      expect(firstTask.status, 'proof');
    });

    test('tidak mengubah apa pun jika ID tidak ditemukan', () {
      final updated = Task(
        id: '999',
        title: 'Invalid',
        designerName: 'X',
        description: 'Invalid',
        imagePath: 'assets/images/login.png',
        status: 'pending',
      );

      controller.updateTask(updated);

      // Tetap 3 karena ID 999 tidak ada
      expect(controller.tasks.length, 3);
    });
  });
}
