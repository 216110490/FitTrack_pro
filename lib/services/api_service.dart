import 'dart:math';

import '../models/fitness_tip.dart';

class ApiService {
  static final List<FitnessTip> _tips = [
    FitnessTip(
      title: 'Stay Consistent',
      body:
          'Consistency is key in fitness. Even short daily workouts can lead to long-term results if you keep doing them regularly.',
    ),
    FitnessTip(
      title: 'Warm Up First',
      body:
          'Always start with a short warm-up before exercising. It helps prepare your muscles and reduces the chance of injury.',
    ),
    FitnessTip(
      title: 'Drink Enough Water',
      body:
          'Staying hydrated helps your body perform better during workouts and supports recovery after exercise.',
    ),
    FitnessTip(
      title: 'Rest Is Important',
      body:
          'Rest days are part of progress. Your muscles need time to recover and become stronger.',
    ),
    FitnessTip(
      title: 'Track Your Progress',
      body:
          'Writing down your workouts helps you see improvement over time and stay motivated.',
    ),
  ];

  static Future<FitnessTip> fetchFitnessTip() async {
    await Future.delayed(const Duration(seconds: 1));

    final random = Random();
    return _tips[random.nextInt(_tips.length)];
  }
}
