import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countStreamProvidertite = StreamProvider<int>((ref) {
  return Stream<int>.periodic(Duration(seconds: 1), (count) => count + 69);
});

void main() {
  runApp(
    ProviderScope(
      child: StreamProviderPractice(),
    ),
  );
}

class StreamProviderPractice extends ConsumerWidget {
  const StreamProviderPractice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countAsync = ref.watch(countStreamProvidertite);
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: countAsync.when(
        data: (data) => Text(data.toString()),
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) => Text('bobo amp'),
      ))),
    );
  }
}
