import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_app/Future%20Provider%20Practice%20API/repository_pokemon.dart';

void main() {
  runApp(
    ProviderScope(
      child: ViewPokemon(),
    ),
  );
}

class ViewPokemon extends ConsumerWidget {
  const ViewPokemon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsyncValue = ref.watch(pokemonProvider);
    print(pokemonAsyncValue.hasValue);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: pokemonAsyncValue.when(
            data: (pokemon) => Column(
              children: [
                Image.network(pokemon.spriteUrl),
                Text(pokemon.name),
                Text(pokemon.id.toString()),
              ],
            ),
            loading: () => CircularProgressIndicator(),
            error: (err, stack) => Text('bobo amp'),
          ),
        ),
      ),
    );
  }
}
