import 'package:flutter/material.dart';

class TipProvider extends ChangeNotifier {
  bool isLoading = false;

  String title = 'Stay Consistent';
  String body =
      'Consistency is key in fitness. Even short daily workouts can lead to long-term results if you keep doing them regularly.';

  Future<void> loadTip() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    title = 'Warm Up First';
    body =
        'Always start with a short warm-up before exercising. It helps prepare your muscles and reduces the chance of injury.';

    isLoading = false;
    notifyListeners();
  }
}
