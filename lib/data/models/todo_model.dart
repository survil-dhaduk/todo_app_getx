import 'package:hive/hive.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';

// Hive type adapter for TodoModel
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends TodoEntity {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final String description;

  @HiveField(3)
  @override
  final DateTime dueDate;

  @HiveField(4)
  @override
  final bool isCompleted;

  @HiveField(5)
  @override
  final DateTime createdAt;

  @HiveField(6) // Reminder field for notifications
  final DateTime? reminder;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
    this.isCompleted = false,
    this.reminder,
  }) : super(
          id: id,
          title: title,
          description: description,
          dueDate: dueDate,
          createdAt: createdAt,
          isCompleted: isCompleted,
        );

  // Factory method to create TodoModel from JSON
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      createdAt: DateTime.parse(json['createdAt']),
      isCompleted: json['isCompleted'] ?? false,
      reminder:
          json['reminder'] != null ? DateTime.parse(json['reminder']) : null,
    );
  }

  // Convert TodoModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
      'reminder': reminder?.toIso8601String(),
    };
  }
}
