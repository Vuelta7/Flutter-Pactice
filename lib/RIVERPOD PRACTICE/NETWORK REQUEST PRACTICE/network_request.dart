import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_request.freezed.dart';
part 'network_request.g.dart';

@freezed
sealed class Activity with _$Activity {
  factory Activity({
    required String key,
    required String activity,
    required String type,
    required int participant,
    required double price,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}

@riverpod
Future<Activity> activity(Ref ref) async {
  final response = await http.get(Uri.https('boredapi.com', '/api/activity'));

  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return Activity.fromJson(json);
}

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
