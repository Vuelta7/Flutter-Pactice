import 'package:flutter/material.dart';

class ChangeNotifierPractice extends ChangeNotifier {
  int counter;
  ChangeNotifierPractice({required this.counter});

  void increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    counter--;
    notifyListeners();
  }
}
