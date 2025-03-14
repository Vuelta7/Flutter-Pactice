import 'package:dio/dio.dart';
import 'package:practice_app/riverpod%20network%20pokemon%20practice/model/network_poke_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_poke_viewmodel.g.dart';

@riverpod
Future<NetworkPokeModel> fetchPokemon(Ref ref) async {
  final response =
      await Dio().get('https://pokeapi.co/api/v2/pokemon/greninja');
  return NetworkPokeModel.fromJson(response.data);
}
