import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:design_manager/data/models/task_model.dart';
import 'package:design_manager/presentation/pages/tasklist/tasklist_controller.dart';

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({super.key});

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _formKey = GlobalKey<FormState>();

  String? _title;
  String? _description;
  String? _category;
  DateTime? _deadline;
  File? _uploadedFile;

  final List<String> _categories = [
    'Poster Design',
    'UI/UX',
    'Photography',
    'Videography',
    'Social Media',
  ];

  // PICK DEADLINE
  Future<void> _pickDeadline(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() => _deadline = pickedDate);
    }
  }

  // PICK FILE
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        _uploadedFile = File(result.files.single.path!);
      });
    }
  }

  // SUBMIT FORM
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _title!,
        designerName: 'Unknown',
        description: _description!,
        imagePath: 'assets/images/default.png',
        status: 'pending',
      );

      // Masukkan ke state (Provider)
      context.read<TasklistController>().addTask(newTask);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task berhasil dibuat ✅')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
        backgroundColor: const Color(0xFF45D1A6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Design Brief",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // TITLE
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Judul Proyek",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Judul wajib diisi' : null,
                onSaved: (v) => _title = v,
              ),
              const SizedBox(height: 16),

              // DESCRIPTION
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Deskripsi Singkat",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Deskripsi wajib diisi' : null,
                onSaved: (v) => _description = v,
              ),
              const SizedBox(height: 16),

              // CATEGORY
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                validator: (v) => v == null ? 'Pilih kategori' : null,
                onChanged: (v) => _category = v,
                initialValue: _category,
              ),
              const SizedBox(height: 16),

              // DEADLINE
              InkWell(
                onTap: () => _pickDeadline(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "Deadline",
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _deadline == null
                        ? "Pilih tanggal"
                        : "${_deadline!.day}/${_deadline!.month}/${_deadline!.year}",
                    style: TextStyle(
                        color: _deadline == null
                            ? Colors.grey[600]
                            : Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // UPLOAD MATERIAL
              const Text(
                "Upload Material Design",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file),
                label: const Text("Pilih File"),
              ),
              const SizedBox(height: 12),

              // PREVIEW FILE
              if (_uploadedFile != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file, color: Colors.black54),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _uploadedFile!.path.split('/').last,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            setState(() => _uploadedFile = null),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 32),

              // SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B894),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Buat Tugas",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
