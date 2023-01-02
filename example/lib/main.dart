import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_snake/flutter_snake.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLUTTER_SNAKE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FLUTTER_SNAKE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<GAME_EVENT>? controller;
  List<CASE_TYPE> _enumList = [];
  bool isPaused = true;

  @override
  void initState() {
    super.initState();
    controller = StreamController<GAME_EVENT>();
    controller?.stream.listen((GAME_EVENT value) {
      print(value.toString());
    });
    addFoods();
  }

  List<dynamic> _foodList = [
    'coin',
    null,
    'cash',
    null,
    'cash',
    'coin',
  ];
  void addFoods() {
    for (var item in _foodList) {
      switch (item) {
        case null:
          _enumList.add(CASE_TYPE.fruit);
          break;
        case 'cash':
          _enumList.add(CASE_TYPE.cash);
          break;
        case 'coin':
          _enumList.add(CASE_TYPE.coin);
          break;
      }
    }
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SnakeGame snakeGame = new SnakeGame(
      isPaused: isPaused,
      foodList: _enumList,
      caseWidth: 25.0,
      numberCaseHorizontally: 14,
      numberCaseVertically: 24,
      controllerEvent: controller,
      defaultSpeed: 400,
      colorBackground1: Color(0XFF7CFC00),
      colorBackground2: Color(0XFF32CD32),
      isLavaEnabled: true,
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            InkWell(
              onTap: (() {
                setState(() {
                  if (isPaused) {
                    isPaused = false;
                  } else {
                    isPaused = true;
                  }
                });
              }),
              child: Icon(Icons.play_arrow),
            ),
          ],
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0.0) {
              snakeGame.nextDirection = SNAKE_MOVE.right;
            } else {
              snakeGame.nextDirection = SNAKE_MOVE.left;
            }
          },
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 0.0) {
              snakeGame.nextDirection = SNAKE_MOVE.down;
            } else {
              snakeGame.nextDirection = SNAKE_MOVE.up;
            }
          },
          child: snakeGame,
        ),
      ),
    );
  }
}
