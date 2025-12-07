import 'package:flutter/material.dart';
import 'package:design_manager/data/models/task_model.dart';

class ReviewTaskDetailPage extends StatefulWidget {
  final Task task;

  const ReviewTaskDetailPage({super.key, required this.task});

  @override
  State<ReviewTaskDetailPage> createState() => _ReviewTaskDetailPageState();
}

class _ReviewTaskDetailPageState extends State<ReviewTaskDetailPage> {
  late String _status;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _status = widget.task.status;
    _commentController = TextEditingController(text: widget.task.comment ?? '');
  }

  void _submitReview() {
    widget.task.status = _status;
    widget.task.comment = _commentController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Review dikirim! Status: $_status")),
    );

    Navigator.pop(context, widget.task);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        backgroundColor: const Color(0xFF45D1A6),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(task.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),

            Text("Designer: ${task.designerName}",
                style: const TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 12),

            Text(task.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 20),

            // Preview gambar desain
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(task.imagePath,
                  width: double.infinity, height: 240, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),

            const Text("Komentar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tambahkan komentar...",
              ),
            ),
            const SizedBox(height: 20),

            const Text("Status Task",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: "proof", child: Text("Menunggu Review")),
                DropdownMenuItem(value: "revision", child: Text("Revision")),
                DropdownMenuItem(value: "accepted", child: Text("Accepted")),
              ],
              onChanged: (value) => setState(() => _status = value!),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _submitReview,
                icon: const Icon(Icons.send),
                label: const Text("Kirim Review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B894),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
