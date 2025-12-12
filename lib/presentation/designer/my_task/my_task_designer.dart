import 'package:design_manager/presentation/designer/my_task/my_task_designer_controller.dart';
import 'package:design_manager/presentation/designer/my_task/widgets/task_card_designer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTaskDesigner extends StatefulWidget {
  const MyTaskDesigner({super.key});

  @override
  State<MyTaskDesigner> createState() => _TasklistPageState();
}

class _TasklistPageState extends State<MyTaskDesigner> {
  String _selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Manager'),
          backgroundColor: const Color(0xFF45D1A6),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFilterBar(context),
              const SizedBox(height: 12),
              Expanded(child: _buildTaskList(context)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/task_form'),
          backgroundColor: const Color(0xFFB2F4C3),
          child: const Icon(Icons.add),
        ),
        
      );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            initialValue: _selectedStatus,
            decoration: const InputDecoration(labelText: 'Status'),
            items: ['All', 'Pending', 'Proof', 'Revision', 'Accepted']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedStatus = value);
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.date_range),
            label: const Text('This Week'),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskList(BuildContext context) {
    final controller = context.watch<MyTaskDesignerController>();
    final tasks = controller.filterByStatus(_selectedStatus);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCardDesigner(
          task: task,
          onTap: () {
            // Arahkan ke halaman review task nanti
            debugPrint('Tapped on ${task.title}');
          },
        );
      },
    );
  }
}
