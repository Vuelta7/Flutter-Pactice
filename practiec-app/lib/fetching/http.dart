// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// main() {
//   runApp(FetchApp());
// }

// class FetchApp extends StatefulWidget {
//   const FetchApp({super.key});

//   @override
//   State<FetchApp> createState() => _FetchAppState();
// }

// class _FetchAppState extends State<FetchApp> {
//   Future<Map<String, dynamic>> fetchData() async {
//     final response = await http.get(
//       Uri.parse('https://pokeapi.co/api/v2/pokemon/greninja'),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: FutureBuilder(
//           future: fetchData(),
//           builder: (context, snapshot) {
//             return Center(
//               child: Text(
//                 snapshot.data.toString(),
//                 textAlign: TextAlign.center,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

main() {
  runApp(ProviderScope(child: Fetching()));
}

final fetchProvider = FutureProvider((ref) async {
  final response = await http.get(
    Uri.parse('https://pokeapi.co/api/v2/pokemon/greninja'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return 'error';
  }
});

class Fetching extends ConsumerWidget {
  const Fetching({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetch = ref.watch(fetchProvider);
    return MaterialApp(
      home: Scaffold(
        body: fetch.when(
          data: (data) => Text(data.toString()),
          error: (err, stack) => Text(err.toString()),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
