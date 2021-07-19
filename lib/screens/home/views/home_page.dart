import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';
import 'package:flutter_snake/widgets/snake/snake_enums/game_event.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double caseWidth = 25.0;
  final int numberCaseHorizontally = 10;
  final int numberCaseVertically = 10;
  StreamController<GAME_EVENT>? controller;
  SnakeGame? snakeGame;

  List<String> _eventList = [];

  @override
  void initState() {
    super.initState();
    controller = StreamController<GAME_EVENT>();

    controller?.stream.listen((GAME_EVENT value) {
      setState(() {
        _eventList.add(value.toString());
      });
    });
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (snakeGame == null) {
      snakeGame = SnakeGame(
        caseWidth: caseWidth,
        numberCaseHorizontally: numberCaseHorizontally,
        numberCaseVertically: numberCaseVertically,
        controllerEvent: controller,
        durationBetweenTicks: Duration(milliseconds: 500),
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: _eventList.length,
          itemBuilder: (BuildContext context, int index) {
            var list  = _eventList.reversed;
            return Container(
              height: 50,
              child: Center(child: Text('EVENT: ${list.elementAt(index)}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
      ],
    );
  }
}
