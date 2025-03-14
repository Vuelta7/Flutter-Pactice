import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_app/change%20notifier%20practice/change_notifier_viewmodel.dart';

void main(List<String> args) {
  runApp(
    ProviderScope(
      child: ChangeNotifierView(),
    ),
  );
}

class ChangeNotifierView extends ConsumerWidget {
  const ChangeNotifierView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changeNotifierCounter = ref.watch(providerPractice);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(changeNotifierCounter.counter.toString()),
              ElevatedButton(
                  onPressed: () {
                    ref.read(providerPractice).increment();
                  },
                  child: Text('increment')),
              ElevatedButton(
                  onPressed: () {
                    ref.read(providerPractice).decrement();
                  },
                  child: Text('decrement'))
            ],
          ),
        ),
      ),
    );
  }
}
