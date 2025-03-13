import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_app/Pokemon%20API%20Practice/my_pokemons_model.dart';
import 'package:practice_app/Pokemon%20API%20Practice/pokemon_apis.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
