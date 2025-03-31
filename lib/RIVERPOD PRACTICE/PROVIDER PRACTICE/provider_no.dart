import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final biasUnis = Provider<String>((ref) {
  return 'Gehlee';
});

void main() {
  runApp(
    ProviderScope(
      child: ProviderPractice(),
    ),
  );
}

class ProviderPractice extends ConsumerWidget {
  const ProviderPractice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String bias = ref.watch(biasUnis);
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Text(bias),
      )),
    );
  }
}
