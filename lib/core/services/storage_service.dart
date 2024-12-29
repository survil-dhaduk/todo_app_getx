import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/todo_model.dart';

class StorageService {
  static const String _todoKey = 'todos';
  final FlutterSecureStorage _secureStorage;

  StorageService() : _secureStorage = const FlutterSecureStorage();

  Future<List<TodoModel>> getTodos() async {
    try {
      final String? todosJson = await _secureStorage.read(key: _todoKey);
      if (todosJson == null) return [];

      final List<dynamic> todosList = json.decode(todosJson);
      return todosList.map((json) => TodoModel.fromJson(json)).toList();
    } catch (e) {
      // Fallback to SharedPreferences if secure storage fails
      final prefs = await SharedPreferences.getInstance();
      final String? todosJson = prefs.getString(_todoKey);
      if (todosJson == null) return [];

      final List<dynamic> todosList = json.decode(todosJson);
      return todosList.map((json) => TodoModel.fromJson(json)).toList();
    }
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    final String todosJson = json.encode(
      todos.map((todo) => todo.toJson()).toList(),
    );

    try {
      await _secureStorage.write(key: _todoKey, value: todosJson);
    } catch (e) {
      // Fallback to SharedPreferences if secure storage fails
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_todoKey, todosJson);
    }
  }
}
