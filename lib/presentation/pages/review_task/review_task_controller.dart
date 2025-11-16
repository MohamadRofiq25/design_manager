import 'package:design_manager/data/models/task_model.dart';

class ReviewTaskController {
  final List<Task> proofTasks = [
    Task(
      id: '1',
      title: 'Poster Feminine Care Spray',
      designerName: 'Mohamad Rofiqul Abror',
      description: 'Poster feminine care spray dengan nuansa merah muda.',
      imagePath: 'assets/images/sample_design_1.png',
      status: 'proof',
    ),
    Task(
      id: '2',
      title: 'Poster Eyelash & Eyebrow Oil Serum',
      designerName: 'Muhammad Iqbal',
      description: 'Desain poster social media post elegan & soft.',
      imagePath: 'assets/images/sample_design_2.png',
      status: 'proof',
    ),
  ];

  void updateTask(Task updatedTask) {
    final index = proofTasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      proofTasks[index] = updatedTask;
    }
  }
}
