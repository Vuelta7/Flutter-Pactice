import 'package:flutter/material.dart';

void main() {
  runApp(Counter2());
}

class Counter2 extends StatelessWidget {
  Counter2({super.key});

  final counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: counter,
          builder: (context, value, _) {
            return ElevatedButton(
              onPressed: () {
                counter.value++;
              },
              child: Text(value.toString()),
            );
          },
        ),
      ),
    );
  }
}
