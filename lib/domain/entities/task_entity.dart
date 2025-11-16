class TaskEntity {
  final String id;
  final String title;
  final String designerName;
  final String status;
  final DateTime? completedAt;

  TaskEntity({
    required this.id,
    required this.title,
    required this.designerName,
    required this.status,
    this.completedAt,
  });
}
