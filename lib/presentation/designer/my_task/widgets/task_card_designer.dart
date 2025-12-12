import 'package:flutter/material.dart';
import 'package:design_manager/data/models/task_model.dart';

class TaskCardDesigner extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskCardDesigner({
    super.key,
    required this.task,
    required this.onTap,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.grey;
      case 'proof':
        return Colors.blue;
      case 'revision':
        return Colors.amber;
      case 'accepted':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(task.status);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(task.imagePath),
          radius: 24,
        ),
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Designer: ${task.designerName}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.status.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
