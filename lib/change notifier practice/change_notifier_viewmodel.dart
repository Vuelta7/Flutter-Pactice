import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_app/change%20notifier%20practice/change_notifier_model.dart';

final providerPractice = ChangeNotifierProvider<ChangeNotifierPractice>((ref) {
  return ChangeNotifierPractice(counter: 0);
});
