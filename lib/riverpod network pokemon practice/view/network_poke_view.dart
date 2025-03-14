import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_app/riverpod%20network%20pokemon%20practice/viewmodel/network_poke_viewmodel.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PokeView(),
    );
  }
}

class PokeView extends ConsumerWidget {
  const PokeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPokemon = ref.watch(fetchPokemonProvider);

    return Scaffold(
      body: Center(
        child: asyncPokemon.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (pokemon) => Image.network(pokemon.sprites.frontDefault),
        ),
      ),
    );
  }
}
