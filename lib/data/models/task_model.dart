class Task {
  final String id;
  final String title;
  final String designerName;
  final String description;
  final String imagePath;
  String status; // pending | proof | revision | accepted
  String? comment;

  Task({
    required this.id,
    required this.title,
    required this.designerName,
    required this.description,
    required this.imagePath,
    required this.status,
    this.comment,
  });
}