import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magic_tech_test_project/models/workout.dart';
import 'package:magic_tech_test_project/provider/user_info.dart';

import 'package:provider/provider.dart';

class NewWorkoutPage extends StatefulWidget {
  static const routeName = '/newWorkoutPage';

  @override
  _NewWorkoutPageState createState() => _NewWorkoutPageState();
}

class _NewWorkoutPageState extends State<NewWorkoutPage> {
  int itemIndex = 0;

  int repetition = 0;
  double weight = 0;

  String _snackBarMessage = '';
  late Workout workout;

  List<String> workoutList = [
    'Barbell row',
    'Bench press',
    'Shoulder press',
    'Deadlift',
    'Squat',
  ];
  List<Workout> userWorkoutList = [];

  int selectedIndex = 0;

  String workoutValue = 'Barbell row';
  bool isNew = true;
  int inWorkout = 0;

  @override
  void didChangeDependencies() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    isNew = args['isNew'];
    inWorkout = args['inWorkout'];

    await getWorkoutList().then((value) async {
      workoutList =
          await Provider.of<UserInfo>(context, listen: false).workoutList;

      workoutValue = workoutList[0];
    });
    await getUserWorkoutList().then((value) async {
      userWorkoutList =
          await Provider.of<UserInfo>(context, listen: false).userWorkoutList;
      if (!isNew) {
        workoutValue = userWorkoutList[inWorkout].name;
        repetition = userWorkoutList[inWorkout].repetition;
        weight = userWorkoutList[inWorkout].weight;
      }
    });

    super.didChangeDependencies();
  }

  Future<List<String>> getWorkoutList() async {
    if (kDebugMode) {
      print('getworkoutList');
    }

    workoutList = Provider.of<UserInfo>(context, listen: false).workoutList;

    if (kDebugMode) {
      print(workoutList.length);
    }

    setState(() {});
    return workoutList;
  }

  Future<void> getUserWorkoutList() async {
    if (kDebugMode) {
      print('getUserWorkoutList');
    }

    userWorkoutList =
        Provider.of<UserInfo>(context, listen: false).userWorkoutList;

    setState(() {});
  }

  Future<bool> addToWorkoutList() async {
    userWorkoutList =
        Provider.of<UserInfo>(context, listen: false).userWorkoutList;
    if (isNew) {
      int id = userWorkoutList.length + 1;
      workout = Workout(
          id: id, name: workoutValue, weight: weight, repetition: repetition);

      await Provider.of<UserInfo>(context, listen: false)
          .addToUserWorkoutList(workout);
    } else {
      int id = userWorkoutList[inWorkout].id;
      workout = Workout(
          id: id, name: workoutValue, weight: weight, repetition: repetition);

      await Provider.of<UserInfo>(context, listen: false)
          .modifyUserWorkoutList(workout, inWorkout);
    }

    setState(() {});
    return true;
  }

  Future<void> showNotification(BuildContext ctx, String message) async {
    SnackBar addToCartSnackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'CircularStd',
          fontSize: 14.0,
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(ctx).showSnackBar(addToCartSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Container(
            height: 30,
            child: Text(
              'New workout record',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'CircularStd',
                fontWeight: FontWeight.w800,
                fontSize: textScaleFactor * 18.0,
              ),
            ),
            // child: ListView.builder(
            //   itemCount: workoutList.length,
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context, index) => Padding(
            //     padding: const EdgeInsets.all(1.0),
            //     child: Container(
            //       height: 2,
            //       width: 20,
            //       color: index <= itemIndex ? Colors.black : Colors.grey,
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 30,
              height: deviceHeight * 0.8,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 37, right: 37, bottom: 0),
                      child: Text(
                        'Select Your workout',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CircularStd',
                          fontWeight: FontWeight.w800,
                          fontSize: textScaleFactor * 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 37, right: 37, bottom: 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(0)),
                          child: DropdownButton<String>(
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Please select',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'CircularStd',
                                  fontSize: textScaleFactor * 11.0,
                                ),
                              ),
                            ),
                            value: workoutValue,
                            icon: const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CircularStd',
                              fontSize: textScaleFactor * 13.0,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                workoutValue = newValue!;
                                selectedIndex = workoutList.indexWhere(
                                    (element) => element == newValue);
                              });
                            },
                            elevation: 0,
                            underline: Container(
                              color: Colors.white,
                            ),
                            items: workoutList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  width: deviceWidth * 0.7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CircularStd',
                                        fontSize: textScaleFactor * 13.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 37, right: 37, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            'Add repetition',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CircularStd',
                              fontWeight: FontWeight.w300,
                              fontSize: textScaleFactor * 12.0,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: 100,
                            color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if (repetition > 0) {
                                        repetition = repetition - 1;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Icon(
                                        repetition > 0
                                            ? Icons.remove
                                            : Icons.delete,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    repetition.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: textScaleFactor * 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    child: InkWell(
                                  onTap: () async {
                                    repetition++;
                                    setState(() {});
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      )),
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 37, right: 37, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            'Add weight(kg)',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CircularStd',
                              fontWeight: FontWeight.w300,
                              fontSize: textScaleFactor * 12.0,
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 100,
                            color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if (weight > 0) {
                                        weight = weight - 0.5;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Icon(
                                        weight > 0
                                            ? Icons.remove
                                            : Icons.delete,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    weight.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: textScaleFactor * 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    child: InkWell(
                                  onTap: () async {
                                    weight = weight + 0.5;
                                    setState(() {});
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      )),
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (isNew) {
            await addToWorkoutList().then((value) {
              _snackBarMessage = 'New workout is add successfully';
              showNotification(context, _snackBarMessage);

              Navigator.of(context).pop();
              setState(() {});
            });
          } else {
            await addToWorkoutList().then((value) {
              _snackBarMessage = 'The record number ${userWorkoutList[inWorkout].id} was modified successfully';

              showNotification(context, _snackBarMessage);


              Navigator.of(context).pop();
              setState(() {});
            });
          }
        },
        tooltip: 'Confirm',
        child: const Icon(Icons.check),
      ),
    );
  }
}
