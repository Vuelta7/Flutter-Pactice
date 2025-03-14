import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_poke_model.g.dart';

@JsonSerializable()
class NetworkPokeModel {
  final String name;
  final Sprites sprites;

  NetworkPokeModel({required this.name, required this.sprites});

  factory NetworkPokeModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkPokeModelFromJson(json);
}

@JsonSerializable()
class Sprites {
  @JsonKey(name: 'front_default')
  final String frontDefault;

  Sprites({required this.frontDefault});

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);
}
