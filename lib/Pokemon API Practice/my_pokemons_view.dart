import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_app/Pokemon%20API%20Practice/my_pokemons_controller.dart';

final count = StreamProvider<int>((ref) {
  return Stream<int>.periodic(Duration(seconds: 1), (count) => count + 69);
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
    final gallade = ref.watch(galladeProvider);
    final counting = ref.watch(count);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              counting.when(
                data: (count) => Text(count.toString()),
                error: (error, stack) => Text('tama na'),
                loading: () => CircularProgressIndicator(),
              ),
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
                  metagross.when(
                    data: (metagross) => Column(
                      children: [
                        Image.network(metagross.spritesUrl),
                        Text(metagross.name),
                      ],
                    ),
                    error: (err, stack) => Text('bobo'),
                    loading: () => CircularProgressIndicator(),
                  ),
                  garchomp.when(
                    data: (garchomp) => Column(
                      children: [
                        Image.network(garchomp.spritesUrl),
                        Text(garchomp.name),
                      ],
                    ),
                    error: (err, stack) => Text('bobo'),
                    loading: () => CircularProgressIndicator(),
                  ),
                  gallade.when(
                    data: (gallade) => Column(
                      children: [
                        Image.network(gallade.spritesUrl),
                        Text(gallade.name),
                      ],
                    ),
                    error: (err, stack) => Text('bobo'),
                    loading: () => CircularProgressIndicator(),
                  )
                ],
              ),
              counting.when(
                data: (count) => Text(count.toString()),
                error: (error, stack) => Text('tama na'),
                loading: () => CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
