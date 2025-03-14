// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_poke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkPokeModel _$NetworkPokeModelFromJson(Map<String, dynamic> json) =>
    NetworkPokeModel(
      name: json['name'] as String,
      sprites: Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
    );

Sprites _$SpritesFromJson(Map<String, dynamic> json) => Sprites(
      frontDefault: json['front_default'] as String,
    );
