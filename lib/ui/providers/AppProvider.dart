import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/model/ToDoModel.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  String _searchQuery = '';

  String get searchQuery => _searchQuery;
  bool _isLoading = true;
  String? _errorMessage;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTodos() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      );

      if (response.statusCode == 200) {
        _todos = (json.decode(response.body) as List)
            .map((data) => Todo.fromJson(data))
            .toList();
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load todos';
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTodo(String title) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        body: json.encode({
          'title': title,
          'completed': false,
        }),
      );

      if (response.statusCode == 201) {
        final newTodo = Todo(
          id: _todos.isEmpty ? 1 : _todos.last.id + 1,
          title: title,
        );
        _todos.add(newTodo);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to add todo: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
      );

      if (response.statusCode == 200) {
        _todos.removeWhere((todo) => todo.id == id);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to delete todo: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/${updatedTodo.id}'),
        body: json.encode(updatedTodo.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
        _todos[index] = updatedTodo;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to update todo: ${e.toString()}';
      notifyListeners();
    }
  }



  List<Todo> get filteredTodos {
    if (_searchQuery.isEmpty) return _todos;
    return _todos.where((todo) =>
        todo.title.toLowerCase().contains(_searchQuery.toLowerCase()),
    ).toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }
}