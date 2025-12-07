import 'package:flutter/material.dart';
import 'package:design_manager/data/models/task_model.dart';

import 'package:design_manager/presentation/manager/pages/review_task/review_task_detail_page.dart';
import 'package:design_manager/presentation/manager/pages/review_task/review_task_controller.dart';

class ReviewTaskPage extends StatefulWidget {
  const ReviewTaskPage({super.key});

  @override
  State<ReviewTaskPage> createState() => _ReviewTaskPageState();
}

class _ReviewTaskPageState extends State<ReviewTaskPage> {
  final ReviewTaskController controller = ReviewTaskController();


  void _openDetail(Task task) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ReviewTaskDetailPage(task: task)),
    );

    if (updatedTask != null) {
      setState(() {
        controller.updateTask(updatedTask);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = controller.proofTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Task'),
        backgroundColor: const Color(0xFF45D1A6),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(task.imagePath, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("By ${task.designerName}"),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.grey),
              onTap: () => _openDetail(task),
            ),
          );
        },
      ),

      
    );
  }
}
