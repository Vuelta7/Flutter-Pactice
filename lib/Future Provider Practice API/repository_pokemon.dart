import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:practice_app/Future%20Provider%20Practice%20API/api.dart';
import 'package:practice_app/Future%20Provider%20Practice%20API/model_pokemon.dart';

final pokemonProvider = FutureProvider<ModelPokemon>((ref) async {
  final response = await http.get(Uri.parse(PokemonApi.pokeApi));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final pokemon = ModelPokemon.fromJson(data);
    return pokemon;
  } else {
    throw Exception('failed to load u pussy');
  }
});
