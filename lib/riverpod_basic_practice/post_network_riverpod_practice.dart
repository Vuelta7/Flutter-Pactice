import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_network_riverpod_practice.g.dart';

class Todo {
  final String title;
  final bool completed;

  Todo({required this.title, this.completed = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
      };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(title: json['title'], completed: json['completed'] ?? false);
  }
}

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=5'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((todo) => Todo.fromJson(todo))
          .toList();
    } else {
      throw Exception('bobo amp');
    }
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      Todo newTodo = Todo.fromJson(jsonDecode(response.body));

      state = AsyncData([...state.value ?? [], newTodo]);
    } else {
      throw Exception('bobo');
    }
  }
}

void main(List<String> args) {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: PostPractice(),
      ),
    ),
  );
}

class PostPractice extends ConsumerStatefulWidget {
  const PostPractice({super.key});

  @override
  ConsumerState<PostPractice> createState() => _PostPracticeState();
}

class _PostPracticeState extends ConsumerState<PostPractice> {
  final TextEditingController task = TextEditingController();

  @override
  void dispose() {
    task.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoList = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: todoList.when(
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              title: Text(todo.title),
              trailing: Icon(
                todo.completed ? Icons.check_circle : Icons.circle_outlined,
                color: todo.completed ? Colors.green : Colors.grey,
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Write a task'),
                  content: TextField(
                    controller: task,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (task.text.isNotEmpty) {
                          ref.read(todoListProvider.notifier).addTodo(
                                Todo(title: task.text),
                              );
                        }
                        task.clear();
                        Navigator.pop(context);
                      },
                      child: Text('Add task'),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
