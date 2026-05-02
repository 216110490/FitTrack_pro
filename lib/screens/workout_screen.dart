import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_provider.dart';
import '../widgets/workout_tile.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final caloriesController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    durationController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  void clearFields() {
    nameController.clear();
    durationController.clear();
    caloriesController.clear();
  }

  void showAddWorkoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Workout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Workout name'),
              ),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Duration'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: caloriesController,
                decoration: const InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                clearFields();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final duration = int.tryParse(durationController.text) ?? 0;
                final calories = int.tryParse(caloriesController.text) ?? 0;

                if (name.isEmpty || duration <= 0 || calories <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid data')),
                  );
                  return;
                }

                await context.read<WorkoutProvider>().addWorkout(
                      name,
                      duration,
                      calories,
                    );

                clearFields();

                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkoutProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.workouts.isEmpty
              ? const Center(
                  child: Text(
                    'No workouts yet. Press + to add one.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: provider.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = provider.workouts[index];

                    return WorkoutTile(
                      workout: workout,
                      onDelete: () {
                        if (workout.id != null) {
                          provider.deleteWorkout(workout.id!);
                        }
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddWorkoutDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
