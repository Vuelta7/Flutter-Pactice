import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    print(response.body);
    List<Todo> newTodos = (jsonDecode(response.body) as List)
        .map((data) => Todo.fromJson(data))
        .toList();

    state = AsyncData(newTodos);
  }
}

void main(List<String> args) {
  runApp(ProviderScope(child: TodoApp()));
}

class TodoApp extends ConsumerWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListAsync = ref.watch(todoListNotifierProvider);

    return MaterialApp(
      home: Scaffold(
        body: todoListAsync.when(
          data: (todos) => ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.description),
                trailing: todo.completed
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
              );
            },
          ),
          error: (error, stackTrace) => Text('bobo'),
          loading: () => CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(todoListNotifierProvider.notifier).addTodo(
                  Todo(description: 'tangina'),
                );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
