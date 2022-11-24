import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/workout.dart';

class UserInfo with ChangeNotifier {
  /// variable list
  List<Workout> _userWorkoutList = [];
  List<String> _workoutList = [
    'Barbell row',
    'Bench press',
    'Shoulder press',
    'Deadlift',
    'Squat',
  ];

  /// getter and setter of variable

  List<Workout> get userWorkoutList => _userWorkoutList;

  set userWorkoutList(List<Workout> value) {
    _userWorkoutList = value;
  }

  List<String> get workoutList => _workoutList;

  set workoutList(List<String> value) {
    _workoutList = value;
  }

  /// add new workout of user to list
  Future<List<Workout>> addToUserWorkoutList(Workout workout) async {
    _userWorkoutList.add(workout);
    return _userWorkoutList;
  }
  /// modify current workout of user to list
  Future<List<Workout>> modifyUserWorkoutList(Workout workout, int index) async {
    _userWorkoutList[index]=workout;
    return _userWorkoutList;
  }

  /// remove workout from user workout list
  Future<List<Workout>> removeFromUserWorkoutList(Workout workout) async {
    _userWorkoutList.remove(workout);
    return _userWorkoutList;
  }
}
