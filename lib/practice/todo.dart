import 'package:flutter/material.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final TextEditingController todo = TextEditingController();
  List todoList = [];

  @override
  void dispose() {
    todo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: Column(
            children: [
              ...todoList.map((item) => ListTile(title: Text(item))),
              TextField(controller: todo),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    todoList.add(todo.text);
                    todo.clear();
                  });
                },
                child: Text('Add task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
