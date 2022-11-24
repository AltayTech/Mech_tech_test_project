// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:magic_tech_test_project/main.dart';
import 'package:magic_tech_test_project/models/workout.dart';
import 'package:magic_tech_test_project/provider/user_info.dart';
import 'package:magic_tech_test_project/screen/my_home_page.dart';
import 'package:magic_tech_test_project/screen/new_workout_page.dart';
import 'package:magic_tech_test_project/widget/workout_listview_item.dart';

void main() {
  group('Sample tests', () {

    /// unit test
    test('add to user workout list', () async {
      var userInfo = UserInfo();
      Workout workout =
          Workout(id: 0, name: 'test name', weight: 2.0, repetition: 10);
      expect(await userInfo.addToUserWorkoutList(workout), [workout]);
    });

    /// widget test
    testWidgets("Flutter Widget Test", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      var text1 = find.text('Bills');
      expect(text1, findsOneWidget);
    });
    testWidgets("Item widget test", (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: WorkoutListviewItem(
            workout:
                Workout(id: 2, name: 'test name', repetition: 10, weight: 10.0),
          )));

      await tester.pumpWidget(testWidget);
      var recordItemid = find.text('No 2');
      var recordItemrepetition = find.text('Repetition');

      expect(recordItemid, findsOneWidget);
      expect(recordItemrepetition, findsOneWidget);
    });





  });
}
