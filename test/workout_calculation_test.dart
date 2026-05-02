import 'package:flutter_test/flutter_test.dart';
import 'package:fittrack_pro/models/workout.dart';

void main() {
  test('total calories calculation works', () {
    final workouts = [
      Workout(name: 'Cardio', duration: 20, calories: 150, date: '2026-01-01'),
      Workout(name: 'Weights', duration: 40, calories: 300, date: '2026-01-01'),
    ];

    final total = workouts.fold(0, (sum, workout) => sum + workout.calories);

    expect(total, 450);
  });
}
