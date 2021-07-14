import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';

class HomePage extends StatelessWidget {
  final double caseWidth = 15.0;
  final int numberCaseHorizontally = 20;
  final int numberCaseVertically = 20;
  SnakeGame? snakeGame;

  @override
  Widget build(BuildContext context) {
    if (snakeGame == null) {
      print("-- INIT SNAKE GAME");
      snakeGame = SnakeGame(
        caseWidth: caseWidth,
        numberCaseHorizontally: numberCaseHorizontally,
        numberCaseVertically: numberCaseVertically,
      );
    }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => snakeGame?.nextDirection = SNAKE_MOVE.left,
              child: Text("LEFT"),
            ),
            TextButton(
              onPressed: () => snakeGame?.nextDirection = SNAKE_MOVE.right,
              child: Text("RIGHT"),
            ),
          ],
        ),
        snakeGame ?? Text("Not initialized"),
      ],
    );
  }
}
