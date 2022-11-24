import 'package:flutter/foundation.dart';

class Workout with ChangeNotifier {
  final int id;
  final String name;
  final double weight;
  final int repetition;

  Workout({
    required this.id,
    required this.name,
    required this.weight,
    required this.repetition,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'weight': this.weight,
      'repetition': this.repetition,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as int,
      name: map['name'] as String,
      weight: map['weight'] as double,
      repetition: map['repetition'] as int,
    );
  }
}
