import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../controllers/todo_controller.dart';
import 'components/todo_input.dart';
import 'components/todo_item.dart';

class HomePage extends GetView<TodoController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _filterChip(AppStrings.all, 'all'),
                _filterChip(AppStrings.pending, 'pending'),
                _filterChip(AppStrings.completed, 'completed'),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inbox,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.emptyTodos,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.filteredTodos.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final todo = controller.filteredTodos[index];
              return TodoItem(todo: todo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.dialog(const TodoInput()),
        label: const Text(AppStrings.addTodo),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _filterChip(String label, String filterValue) {
    return Obx(
      () => FilterChip(
        label: Text(label),
        selected: controller.filter.value == filterValue,
        onSelected: (selected) {
          if (selected) {
            controller.filter.value = filterValue;
          }
        },
      ),
    );
  }
}
