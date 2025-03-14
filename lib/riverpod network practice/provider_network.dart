import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:practice_app/riverpod%20network%20practice/network_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider_network.g.dart';

@riverpod
Future<Activity> activity(Ref ref) async {
  final response = await http.get(Uri.https('boredapi.com', '/api/activity'));

  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return Activity.fromJson(json);
}
