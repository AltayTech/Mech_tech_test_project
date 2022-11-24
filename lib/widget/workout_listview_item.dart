import 'package:flutter/material.dart';
import 'package:magic_tech_test_project/models/workout.dart';


class WorkoutListviewItem extends StatelessWidget {
  final Workout workout;

  const WorkoutListviewItem({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 4, left: 0, top: 1, bottom: 4),
                    child: Text(
                      'No ${workout.id}',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: textScaleFactor * 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: DataRow(
                      title: "Workout name",
                      amount: workout.name.toString(),
                      dimension: '',
                    ),
                  ),
                  Expanded(
                    child: DataRow(
                      title: "Weight",
                      amount: "\$${workout.weight.toString()}",
                      dimension: '',
                    ),
                  ),
                  Expanded(
                    child: DataRow(
                      title: "Repetition",
                      amount: workout.repetition.toString(),
                      dimension: '',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DataRow extends StatelessWidget {
  const DataRow({
    Key? key,
    required this.title,
    required this.amount,
    required this.dimension,
  }) : super(key: key);

  final String title;
  final String amount;
  final String dimension;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
            child: Text(
              title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'CircularStd',
                color: Colors.grey,
                fontSize: textScaleFactor * 12.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 4, left: 0, top: 1, bottom: 4),
            child: Text(
              '$amount ${dimension != null ? dimension : ''}',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontFamily: 'CircularStd',
                  color: Colors.black,
                  fontSize: textScaleFactor * 14.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
