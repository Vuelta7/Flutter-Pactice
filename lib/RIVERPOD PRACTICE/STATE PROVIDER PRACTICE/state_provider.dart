import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final riverpodEasy = StateProvider<int>((ref) {
  return 0;
});
void main() {
  runApp(ProviderScope(child: RiverpodPractice()));
}

class RiverpodPractice extends StatelessWidget {
  const RiverpodPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Riverpod(),
    );
  }
}

class Riverpod extends ConsumerWidget {
  const Riverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(ref.watch(riverpodEasy).toString()),
            ElevatedButton(
                onPressed: () {
                  ref.read(riverpodEasy.notifier).state++;
                },
                child: Text('increase')),
            ElevatedButton(
                onPressed: () {
                  ref.read(riverpodEasy.notifier).state--;
                },
                child: Text('decrease')),
          ],
        ),
      ),
    );
  }
}
