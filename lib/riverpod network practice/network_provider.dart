import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_provider.freezed.dart';
part 'network_provider.g.dart';

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
