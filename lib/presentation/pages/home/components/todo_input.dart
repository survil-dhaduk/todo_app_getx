import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/utils/notification_service.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/main.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../controllers/todo_controller.dart';


class TodoInput extends GetView<TodoController> {
  const TodoInput({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    TimeOfDay? selectedTime; // Variable to hold selected time

    return AlertDialog(
      title: const Text(AppStrings.addTodo),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: AppStrings.todoHint,
            ),
          ),
          // Button to pick time
          TextButton(
            onPressed: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                selectedTime = time; // Store the selected time
              }
            },
            child: const Text('Set Reminder Time'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () async {
            if (textController.text.isNotEmpty) {
              controller.addTodo(textController.text);
              if (selectedTime != null) {
                final now = DateTime.now();
                final reminderTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );

                if (reminderTime.isAfter(now)) {
                  // Schedule the notification
                  final notificationService =NotificationService();
                  await notificationService.scheduleTodoNotification(
                    TodoModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: textController.text,
                      description: '',
                      dueDate: reminderTime,
                      createdAt: DateTime.now(),
                      isCompleted: false,
                      reminder: reminderTime,
                    ),
                  );
                }
              }
              Get.back();
            }
          },
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }
}
