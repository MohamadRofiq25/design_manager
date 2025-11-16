import 'package:flutter/material.dart';
import 'package:design_manager/data/models/task_model.dart';

class TasklistController extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Product Banner Design',
      designerName: 'Sarah',
      description: 'Banner promosi untuk produk baru.',
      imagePath: 'assets/images/login.png',
      status: 'pending',
    ),
    Task(
      id: '2',
      title: 'Instagram Story Template',
      designerName: 'Ahmad',
      description: 'Template untuk story Instagram promosi.',
      imagePath: 'assets/images/login.png',
      status: 'proof',
    ),
    Task(
      id: '3',
      title: 'Promo 11.11 Poster',
      designerName: 'Lina',
      description: 'Poster promosi event 11.11.',
      imagePath: 'assets/images/login.png',
      status: 'revision',
    ),
  ];

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> filterByStatus(String status) {
    if (status.toLowerCase() == 'all') return _tasks;
    return _tasks.where((t) => t.status == status.toLowerCase()).toList();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }
}
