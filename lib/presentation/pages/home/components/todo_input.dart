import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../controllers/todo_controller.dart';

class TodoInput extends GetView<TodoController> {
  const TodoInput({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return AlertDialog(
      title: const Text(AppStrings.addTodo),
      content: TextField(
        controller: textController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: AppStrings.todoHint,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            if (textController.text.isNotEmpty) {
              controller.addTodo(textController.text);
              Get.back();
            }
          },
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }
}
