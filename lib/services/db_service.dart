import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/workout.dart';

class DbService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'fittrack_phase3.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE workouts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            duration INTEGER NOT NULL,
            calories INTEGER NOT NULL,
            date TEXT NOT NULL
          )
        ''');
      },
    );

    return _database!;
  }

  static Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    return db.insert('workouts', workout.toMap());
  }

  static Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final maps = await db.query('workouts', orderBy: 'id DESC');
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  static Future<int> updateWorkout(Workout workout) async {
    final db = await database;
    return db.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }

  static Future<int> deleteWorkout(int id) async {
    final db = await database;
    return db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
