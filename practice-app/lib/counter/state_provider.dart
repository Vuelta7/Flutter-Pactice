import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: Counter3()));
}

class Counter3 extends ConsumerWidget {
  const Counter3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: ElevatedButton(
          onPressed: () {
            ref.read(count.notifier).state++;
          },
          child: Text(ref.watch(count).toString()),
        ),
      ),
    );
  }
}

final count = StateProvider((ref) => 0);
