import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';

class HomePage extends StatelessWidget {
  final double caseWidth = 25.0;
  final int numberCaseHorizontally = 10;
  final int numberCaseVertically = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          "Snake game",
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "Parameters:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("- caseWidth: $caseWidth"),
        Text("- numberCaseHorizontally: $numberCaseHorizontally"),
        Text("- numberCaseVertically: $numberCaseVertically"),
        SizedBox(
          height: 32,
        ),
        SnakeGame(
          caseWidth: caseWidth,
          numberCaseHorizontally: numberCaseHorizontally,
          numberCaseVertically: numberCaseVertically,
        ),
      ],
    );
  }
}
