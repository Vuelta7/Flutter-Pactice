import 'package:flutter/material.dart';
import 'package:practice_app/practice/test.dart';

void main() {
  runApp(ChatScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(),
    );
  }
}
