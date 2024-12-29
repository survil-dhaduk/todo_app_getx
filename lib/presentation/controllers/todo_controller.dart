import 'package:get/get.dart';

import '../../core/services/storage_service.dart';
import '../../data/models/todo_model.dart';

class TodoController extends GetxController {
  final RxList<TodoModel> todos = <TodoModel>[].obs;
  final RxString filter = 'all'.obs;
  final StorageService _storage = StorageService();

  @override
  void onInit() {
    super.onInit();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final storedTodos = await _storage.getTodos();
    todos.assignAll(storedTodos);
  }

  Future<void> addTodo(String title) async {
    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: '',
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
      isCompleted: false,
    );
    todos.add(todo);
    await _storage.saveTodos(todos.map((todo) => todo).toList());
  }

  Future<void> toggleTodo(String id) async {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = todos[index];
      todos[index] = TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        dueDate: todo.dueDate,
        createdAt: todo.createdAt,
        isCompleted: !todo.isCompleted,
      );
      await _storage.saveTodos(todos.map((todo) => todo).toList());
    }
  }

  Future<void> deleteTodo(String id) async {
    todos.removeWhere((todo) => todo.id == id);
    await _storage.saveTodos(todos.map((todo) => todo).toList());
  }

  List<TodoModel> get filteredTodos {
    switch (filter.value) {
      case 'completed':
        return todos.where((todo) => todo.isCompleted).toList();
      case 'pending':
        return todos.where((todo) => !todo.isCompleted).toList();
      default:
        return todos;
    }
  }
}
