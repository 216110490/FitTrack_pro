import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../services/db_service.dart';

class WorkoutProvider extends ChangeNotifier {
  List<Workout> _workouts = [];
  bool _isLoading = false;

  List<Workout> get workouts => _workouts;
  bool get isLoading => _isLoading;

  int get totalWorkouts => _workouts.length;

  int get totalCalories {
    return _workouts.fold(0, (sum, workout) => sum + workout.calories);
  }

  int get totalDuration {
    return _workouts.fold(0, (sum, workout) => sum + workout.duration);
  }

  double get averageCalories {
    if (_workouts.isEmpty) return 0;
    return totalCalories / _workouts.length;
  }

  Future<void> loadWorkouts() async {
    _isLoading = true;
    notifyListeners();

    _workouts = await DbService.getWorkouts();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addWorkout(String name, int duration, int calories) async {
    final workout = Workout(
      name: name,
      duration: duration,
      calories: calories,
      date: DateTime.now().toString().substring(0, 10),
    );

    await DbService.insertWorkout(workout);
    await loadWorkouts();
  }

  Future<void> updateWorkout(Workout workout) async {
    await DbService.updateWorkout(workout);
    await loadWorkouts();
  }

  Future<void> deleteWorkout(int id) async {
    await DbService.deleteWorkout(id);
    await loadWorkouts();
  }
}
