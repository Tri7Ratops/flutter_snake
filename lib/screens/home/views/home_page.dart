import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';

class HomePage extends StatelessWidget {
  final int caseWidth = 10;
  final int numberCaseHorizontally = 10;
  final int numberCaseVertically = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Snake game",
          style: Theme.of(context).textTheme.headline3,
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
