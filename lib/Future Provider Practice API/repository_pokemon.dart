import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:practice_app/Future%20Provider%20Practice%20API/model_pokemon.dart';

final pokemonProvider = FutureProvider<ModelPokemon>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/greninja'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("$data tite");
    final pokemon = ModelPokemon.fromJson(data); //i think this is not working
    print("Parsed Model: ${pokemon.name}");
    return pokemon;
  } else {
    throw Exception('failed to load u pussy');
  }
});
