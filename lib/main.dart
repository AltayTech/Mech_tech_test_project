import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_info.dart';
import 'screen/my_home_page.dart';
import 'screen/new_workout_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserInfo(),
        ),
      ],
      child: MaterialApp(
        title: 'Magic Tech',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Magic Tech'),
        routes: {
          NewWorkoutPage.routeName: (ctx) => NewWorkoutPage(),
        },
      ),
    );
  }
}
