import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'network_request_no.freezed.dart';
part 'network_request_no.g.dart';

@freezed
abstract class MyPokemonsModel with _$MyPokemonsModel {
  const factory MyPokemonsModel({
    required String name,
    required String spritesUrl,
  }) = _MyPokemonsModel;

  factory MyPokemonsModel.fromJson(Map<String, dynamic> json) =>
      _$MyPokemonsModelFromJson(json);
}

String _spriteFromJson(Map<String, dynamic>? sprites) {
  return sprites?['front_default'] ?? '';
}

final greninjaProvider = FutureProvider<MyPokemonsModel>((ref) async {
  final response = await http.get(Uri.parse(PokemonApis.greninja));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return MyPokemonsModel.fromJson(data);
  } else {
    throw Exception('bobo amp');
  }
});

final lucarioProvider = FutureProvider<MyPokemonsModel>((ref) async {
  final response = await http.get(Uri.parse(PokemonApis.lucario));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return MyPokemonsModel.fromJson(data);
  } else {
    throw Exception('tanga amp');
  }
});

final metagrossProvider = FutureProvider<MyPokemonsModel>((ref) async {
  final response = await http.get(Uri.parse(PokemonApis.metagross));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return MyPokemonsModel.fromJson(data);
  } else {
    throw Exception('loko ang tanga mo');
  }
});

final charizardProvider = FutureProvider<MyPokemonsModel>((ref) async {
  final response = await http.get(Uri.parse(PokemonApis.charizard));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return MyPokemonsModel.fromJson(data);
  } else {
    throw Exception('gago bagal mo mag type');
  }
});

final garchompProvider = FutureProvider<MyPokemonsModel>((ref) async {
  final response = await http.get(Uri.parse(PokemonApis.garchomp));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return MyPokemonsModel.fromJson(data);
  } else {
    throw Exception('bobo amp tanga modin promise');
  }
});

final galladeProvider = FutureProvider<MyPokemonsModel>((ref) async {
  final response = await http.get(Uri.parse(PokemonApis.gallade));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return MyPokemonsModel.fromJson(data);
  } else {
    throw Exception('tanga, ayos lang yan, pero bobo mo');
  }
});

void main(List<String> args) {
  runApp(
    ProviderScope(
      child: MyPokemonsView(),
    ),
  );
}

class MyPokemonsView extends ConsumerWidget {
  const MyPokemonsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charizard = ref.watch(charizardProvider);
    final lucario = ref.watch(lucarioProvider);
    final greninja = ref.watch(greninjaProvider);
    final metagross = ref.watch(metagrossProvider);
    final garchomp = ref.watch(garchompProvider);
    final AsyncValue<MyPokemonsModel> gallade = ref.watch(galladeProvider);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  charizard.when(
                    data: (charizard) => Column(
                      children: [
                        Image.network(charizard.spritesUrl),
                        Text(charizard.name),
                      ],
                    ),
                    error: (err, stack) => Text('bobo'),
                    loading: () => CircularProgressIndicator(),
                  ),
                  lucario.when(
                    data: (lucario) => Column(
                      children: [
                        Image.network(lucario.spritesUrl),
                        Text(lucario.name),
                      ],
                    ),
                    error: (err, stack) => Text('bobo'),
                    loading: () => CircularProgressIndicator(),
                  ),
                  greninja.when(
                    data: (greninja) => Column(
                      children: [
                        Image.network(greninja.spritesUrl),
                        Text(greninja.name),
                      ],
                    ),
                    error: (err, stack) => Text('bobo'),
                    loading: () => CircularProgressIndicator(),
                  ),
                  switch (metagross) {
                    AsyncData(:final value) => Column(
                        children: [
                          Image.network(value.spritesUrl),
                          Text(value.name),
                        ],
                      ),
                    AsyncError() => Text('bobo'),
                    _ => CircularProgressIndicator(),
                  },
                  switch (garchomp) {
                    AsyncData(:final value) => Column(
                        children: [
                          Image.network(value.spritesUrl),
                          Text(value.name),
                        ],
                      ),
                    AsyncError() => Text('bobo'),
                    _ => CircularProgressIndicator(),
                  },
                  switch (gallade) {
                    AsyncData(:final value) => Column(
                        children: [
                          Image.network(value.spritesUrl),
                          Text(value.name),
                        ],
                      ),
                    AsyncError() => Text('dumbass'),
                    _ => CircularProgressIndicator(),
                  }
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PokemonApis {
  static const String pokeApi = 'https://pokeapi.co/api/v2/pokemon/';
  static const String greninja = 'https://pokeapi.co/api/v2/pokemon/greninja';
  static const String lucario = 'https://pokeapi.co/api/v2/pokemon/lucario';
  static const String metagross = 'https://pokeapi.co/api/v2/pokemon/metagross';
  static const String charizard = 'https://pokeapi.co/api/v2/pokemon/charizard';
  static const String garchomp = 'https://pokeapi.co/api/v2/pokemon/garchomp';
  static const String gallade = 'https://pokeapi.co/api/v2/pokemon/gallade';
}
