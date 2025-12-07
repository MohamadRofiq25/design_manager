import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_manager/presentation/manager/pages/create_task/create_task_controller.dart';

class CreateTaskForm extends StatelessWidget {
  const CreateTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateTaskController(),
      child: Consumer<CreateTaskController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Create Task"),
              backgroundColor: const Color(0xFF45D1A6),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
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
                      validator: (value) =>
                          value == null || value.isEmpty ? "Judul wajib diisi" : null,
                      onSaved: (value) => controller.title = value,
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
                      validator: (value) =>
                          value == null || value.isEmpty ? "Deskripsi wajib diisi" : null,
                      onSaved: (value) => controller.description = value,
                    ),
                    const SizedBox(height: 16),

                    // CATEGORY
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Kategori",
                        border: OutlineInputBorder(),
                      ),
                      items: controller.categories
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (value) => controller.category = value,
                      validator: (value) => value == null ? "Pilih kategori" : null,
                    ),
                    const SizedBox(height: 16),

                    // DEADLINE
                    InkWell(
                      onTap: () => controller.pickDeadline(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Deadline",
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          controller.deadline == null
                              ? "Pilih tanggal"
                              : "${controller.deadline!.day}/${controller.deadline!.month}/${controller.deadline!.year}",
                          style: TextStyle(
                            color: controller.deadline == null
                                ? Colors.grey[600]
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Upload Material Design",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    OutlinedButton.icon(
                      onPressed: controller.pickFile,
                      icon: const Icon(Icons.upload_file),
                      label: const Text("Pilih File"),
                    ),
                    const SizedBox(height: 12),

                    if (controller.uploadedFile != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.insert_drive_file,
                                color: Colors.black54),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                controller.uploadedFile!.path.split('/').last,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: controller.removeFile,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final success = controller.submitForm(context);
                          if (success) Navigator.pop(context);
                        },
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
