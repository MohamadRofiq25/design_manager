import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CreateTaskController extends ChangeNotifier {
  String? title;
  String? description;
  String? category;
  DateTime? deadline;
  File? uploadedFile;

  final List<String> categories = [
    'Poster Design',
    'UI/UX',
    'Photography',
    'Videography',
    'Social Media',
  ];

  final formKey = GlobalKey<FormState>();

  // PILIH DEADLINE
  Future<void> pickDeadline(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      deadline = pickedDate;
      notifyListeners();
    }
  }

  // PILIH FILE
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      uploadedFile = File(result.files.single.path!);
      notifyListeners();
    }
  }

  // HAPUS FILE
  void removeFile() {
    uploadedFile = null;
    notifyListeners();
  }

  // SUBMIT FORM
  bool submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      debugPrint('✔ Task berhasil dibuat');
      debugPrint('Title: $title');
      debugPrint('Description: $description');
      debugPrint('Category: $category');
      debugPrint('Deadline: $deadline');
      debugPrint('File: ${uploadedFile?.path}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task berhasil dibuat")),
      );

      return true;
    }
    return false;
  }
}
