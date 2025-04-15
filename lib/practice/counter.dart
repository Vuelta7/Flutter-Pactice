import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Counter());
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(num.toString()),
              ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        num++;
                      },
                    );
                  },
                  child: Text('increment')),
              ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        num--;
                      },
                    );
                  },
                  child: Text('decrement')),
            ],
          ),
        ),
      ),
    );
  }
}
