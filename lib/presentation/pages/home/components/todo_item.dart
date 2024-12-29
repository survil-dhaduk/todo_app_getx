import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/models/todo_model.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../domain/entities/todo_entity.dart';
import '../../../controllers/todo_controller.dart';

class TodoItem extends GetView<TodoController> {
  final TodoModel todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => controller.toggleTodo(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          todo.dueDate.toString().split('.')[0],
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => Get.dialog(
            AlertDialog(
              title: const Text(AppStrings.deleteTodo),
              content: const Text(AppStrings.confirmDelete),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(AppStrings.cancel),
                ),
                TextButton(
                  onPressed: () {
                    controller.deleteTodo(todo.id);
                    Get.back();
                  },
                  child: const Text(AppStrings.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
