class Workout {
  final int? id;
  final String name;
  final int duration;
  final int calories;
  final String date;

  Workout({
    this.id,
    required this.name,
    required this.duration,
    required this.calories,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'calories': calories,
      'date': date,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as int?,
      name: map['name'] as String,
      duration: map['duration'] as int,
      calories: map['calories'] as int,
      date: map['date'] as String,
    );
  }
}
