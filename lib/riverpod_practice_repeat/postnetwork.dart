import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'postnetwork.g.dart';

class Todo2 {
  String title;
  bool completed;

  Todo2({
    required this.title,
    required this.completed,
  });

  factory Todo2.fromJson(Map<String, dynamic> json) => Todo2(
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "completed": completed,
      };
}

@riverpod
class Todolist2 extends _$Todolist2 {
  @override
  Future<List<Todo2>> build() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=5'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((todo) => Todo2.fromJson(todo))
          .toList();
    } else {
      throw Exception('bobo');
    }
  }

  Future<void> addTodo(Todo2 todo) async {
    final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(todo.toJson()));
    print(response.body);

    if (response.statusCode == 201) {
      Todo2 newTodo = Todo2.fromJson(jsonDecode(response.body));

      state = AsyncData([...state.value ?? [], newTodo]);
    } else {
      throw Exception('bobo');
    }
  }
}

void main(List<String> args) {
  runApp(
    ProviderScope(child: Tite()),
  );
}

class Tite extends ConsumerWidget {
  const Tite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kapagodAmp = ref.watch(todolist2Provider);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              kapagodAmp.when(
                  data: (data) => Text(data.toString()),
                  error: (err, e) => Text('bobo'),
                  loading: () => CircularProgressIndicator()),
              ElevatedButton(
                  onPressed: () {
                    ref
                        .read(todolist2Provider.notifier)
                        .addTodo(Todo2(title: 'tite', completed: true));
                  },
                  child: Text('button'))
            ],
          ),
        ),
      ),
    );
  }
}
