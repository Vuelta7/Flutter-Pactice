import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

void main(List<String> args) {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: WarningStreak(),
      ),
    ),
  );
}

class WarningStreak extends StatelessWidget {
  const WarningStreak({super.key});

  void _showWarningDialog(context, Color color) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color,
          title: const Text(
            'Warning',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'press',
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/sadstar.json'),
              const Text(
                'You missed a day! If you miss another day, your streak points will reset to 0.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'press',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'press',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showWarningDialog(context, Colors.blue),
          child: const Text('Show Warning'),
        ),
      ),
    );
  }
}
