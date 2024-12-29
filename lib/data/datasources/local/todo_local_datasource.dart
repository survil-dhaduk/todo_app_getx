import 'package:hive/hive.dart';
import 'package:todo_app/data/models/todo_model.dart';

class TodoLocalDataSource {
  final Box<TodoModel> _todoBox = Hive.box<TodoModel>('todos');

  Future<List<TodoModel>> getTodos() async {
    return _todoBox.values.toList();
  }

  Future<void> addTodo(TodoModel todo) async {
    await _todoBox.put(todo.id, todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _todoBox.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await _todoBox.delete(id);
  }
}
