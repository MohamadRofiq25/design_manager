import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_manager/presentation/manager/pages/create_task/create_task_controller.dart';

void main() {
  group('CreateTaskController Unit Test', () {
    late CreateTaskController controller;

    setUp(() {
      controller = CreateTaskController();
    });

    test('Initial values should be null', () {
      expect(controller.title, null);
      expect(controller.description, null);
      expect(controller.category, null);
      expect(controller.deadline, null);
      expect(controller.uploadedFile, null);

      expect(controller.designer.isNotEmpty, true);
      expect(controller.formKey, isNotNull);
    });

    test('Should update title, description, and category', () {
      controller.title = "Judul Task";
      controller.description = "Deskripsi Task";
      controller.category = "UI Design";

      expect(controller.title, "Judul Task");
      expect(controller.description, "Deskripsi Task");
      expect(controller.category, "UI Design");
    });

    test('removeFile should set uploadedFile to null and notify listeners', () {
      var notifyCount = 0;
      controller.addListener(() {
        notifyCount++;
      });

      // Simulasi file
      controller.uploadedFile = File("dummy.txt");

      controller.removeFile();

      expect(controller.uploadedFile, null);
      expect(notifyCount, 1);
    });

    test('Setting deadline manually should work (without datePicker)', () {
      var notifyCount = 0;
      controller.addListener(() {
        notifyCount++;
      });

      final testDate = DateTime(2025, 1, 1);
      controller.deadline = testDate;
      controller.notifyListeners(); // manual trigger since pickDeadline uses UI

      expect(controller.deadline, testDate);
      expect(notifyCount, 1);
    });
  });
}
