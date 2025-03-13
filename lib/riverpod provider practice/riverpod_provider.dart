import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_provider.g.dart';

// dart run build_runner build
@riverpod
String city(Ref ref) => 'Malolos';

@riverpod
String province(Ref ref) => 'Bulacan';

void main() {
  runApp(ProviderScope(child: Practice()));
}

class Practice extends ConsumerWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String city = ref.watch(provinceProvider);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(city),
        ),
      ),
    );
  }
}
