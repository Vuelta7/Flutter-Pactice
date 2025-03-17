import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'postnetwork3.g.dart';

class Todo {
  final String description;
  final bool completed;

  Todo({required this.description, this.completed = false});

  Map<String, dynamic> toJson() => {
        'description': description,
        'completed': completed,
      };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      description: json['description'],
      completed: json['completed'],
    );
  }
}

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  Future<List<Todo>> build() async {
    return [
      Todo(description: 'Learn Flutter', completed: true),
      Todo(description: 'learn riverfuckingpod'),
    ];
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.https('https://jsonplaceholder.typicode.com/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    List<Todo> newTodos = (jsonDecode(response.body) as List)
        .map((data) => Todo.fromJson(data))
        .toList();

    state = AsyncData(newTodos);
  }
}
