import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp();
  }
}

// const SizedBox(height: 20),
// SizedBox(
//   child: ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.amber,
//       minimumSize: const Size(double.infinity, 50),
//     ),
//     onPressed: () {},
//     child: Text(
//       'ORDER NOW',
//       style: GoogleFonts.poppins(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//   ),
// ),
// const SizedBox(height: 10),
// SizedBox(
//   child: OutlinedButton(
//     style: OutlinedButton.styleFrom(
//       minimumSize: const Size(double.infinity, 50),
//     ),
//     onPressed: () {},
//     child: Text(
//       'View Food Information',
//       style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
//     ),
//   ),
// ),
