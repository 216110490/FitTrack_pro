import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_provider.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkoutProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FitTrack Pro'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: provider.loadWorkouts,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Fitness Dashboard',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text('Track your workouts and progress in a simple way.'),
            const SizedBox(height: 20),
            Row(
              children: [
                SummaryCard(
                  title: 'Workouts',
                  value: provider.totalWorkouts.toString(),
                  icon: Icons.fitness_center,
                ),
                const SizedBox(width: 10),
                SummaryCard(
                  title: 'Calories',
                  value: provider.totalCalories.toString(),
                  icon: Icons.local_fire_department,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SummaryCard(
                  title: 'Minutes',
                  value: provider.totalDuration.toString(),
                  icon: Icons.timer,
                ),
                const SizedBox(width: 10),
                SummaryCard(
                  title: 'Avg Cal',
                  value: provider.averageCalories.toStringAsFixed(0),
                  icon: Icons.trending_up,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Card(
              child: ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Phase 3 Concepts'),
                subtitle: Text(
                  'Provider, SQLite, REST API, image picker, responsive UI, and theme mode.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
