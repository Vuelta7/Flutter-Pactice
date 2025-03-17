import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerPractice = ChangeNotifierProvider<ChangeNotifierPractice>((ref) {
  return ChangeNotifierPractice(counter: 0);
});

class ChangeNotifierPractice extends ChangeNotifier {
  int counter;
  ChangeNotifierPractice({required this.counter});

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    counter--;
    notifyListeners();
  }
}

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
                child: Text('increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(providerPractice).decrement();
                },
                child: Text('decrement'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
