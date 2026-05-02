import 'package:flutter/material.dart';

import '../models/workout.dart';

class WorkoutTile extends StatelessWidget {
  final Workout workout;
  final VoidCallback onDelete;

  const WorkoutTile({
    super.key,
    required this.workout,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.fitness_center),
        ),
        title: Text(workout.name),
        subtitle: Text(
          '${workout.duration} minutes • ${workout.calories} calories • ${workout.date}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
