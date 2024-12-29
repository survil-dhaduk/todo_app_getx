abstract class TodoEntity {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final DateTime createdAt;
  final bool isCompleted;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
    this.isCompleted = false,
  });
}
