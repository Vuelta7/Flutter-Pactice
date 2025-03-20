// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_request_no.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MyPokemonsModel _$MyPokemonsModelFromJson(Map<String, dynamic> json) =>
    _MyPokemonsModel(
      name: json['name'] as String,
      spritesUrl: _spriteFromJson(json['sprites'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$MyPokemonsModelToJson(_MyPokemonsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sprites': instance.spritesUrl,
    };
