import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_app/riverpod%20network%20practice/network_provider.dart';
import 'package:practice_app/riverpod%20network%20practice/provider_network.dart';

void main() {
  runApp(
    ProviderScope(
      child: NetworkConsumer(),
    ),
  );
}

class NetworkConsumer extends ConsumerWidget {
  const NetworkConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Activity> activity = ref.watch(activityProvider);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: switch (activity) {
            AsyncData(:final value) => Text('Activity: ${value.activity}'),
            AsyncError() => const Text('Oops, u dumbass'),
            _ => const CircularProgressIndicator(),
          },
        ),
      ),
    );
  }
}
