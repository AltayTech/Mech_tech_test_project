import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/workout.dart';
import '../provider/user_info.dart';
import '../widget/workout_listview_item.dart';
import 'new_workout_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const routeName = '/BillsScreen';

  List<Workout> userWorkoutList = [];

  late Workout workout;

  Future<String> getUserWorkoutList() async {
    if (kDebugMode) {
      print('getUserWorkoutList');
    }

    userWorkoutList =
        Provider.of<UserInfo>(context, listen: false).userWorkoutList;

    setState(() {});
    return 'true';
  }

  @override
  Widget build(BuildContext context) {
    getUserWorkoutList();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    userWorkoutList = Provider.of<UserInfo>(
      context,
    ).userWorkoutList;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: 250,
              width: deviceWidth,
              child: Image.asset(
                'assets/images/main_screen_header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              width: deviceWidth,
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.01),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                    child: Text(
                      'Bills',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: textScaleFactor * 24.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                          child: userWorkoutList.isNotEmpty
                              ? ListView.builder(
                                  // controller: _scrollController,
                                  // scrollDirection: Axis.vertical,
                                  itemCount: userWorkoutList.length,
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (ctx, i) => Dismissible(
                                    key: Key(userWorkoutList.toString()),
                                    onDismissed: (direction) {
                                      // Remove the item from the data source.
                                      setState(() {
                                        userWorkoutList.removeAt(i);
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            NewWorkoutPage.routeName,
                                            arguments: {
                                              'isNew': false,
                                              'inWorkout': i,
                                            }).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(bottom: 6),
                                        width: deviceWidth,
                                        height: 135,
                                        child: WorkoutListviewItem(
                                          workout: userWorkoutList[i],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'You Have No bill List',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: 'CircularStd',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: textScaleFactor * 16.0,
                                      ),
                                    ),
                                  ),
                                )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            NewWorkoutPage.routeName,
            arguments: {
              'isNew': true,
              'inWorkout': 0,
            },
          ).then((value) {
            setState(() {});
          });
        },
        tooltip: 'New Record',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
