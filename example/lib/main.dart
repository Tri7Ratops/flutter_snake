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
  SnakeGame? snakeGame;

  @override
  void initState() {
    super.initState();
    controller = StreamController<GAME_EVENT>();
    controller?.stream.listen((GAME_EVENT value) {
      print(value.toString());
    });

    snakeGame = new SnakeGame(
      caseWidth: 25.0,
      numberCaseHorizontally: 11,
      numberCaseVertically: 11,
      controllerEvent: controller,
      durationBetweenTicks: Duration(milliseconds: 400),
      colorBackground1: Color(0XFF7CFC00),
      colorBackground2: Color(0XFF32CD32),
    );
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => snakeGame?.nextDirection = SNAKE_MOVE.left,
                  icon: Icon(Icons.subdirectory_arrow_left),
                ),
                Text("SNAKE"),
                IconButton(
                  onPressed: () => snakeGame?.nextDirection = SNAKE_MOVE.right,
                  icon: Icon(Icons.subdirectory_arrow_right),
                ),
              ],
            ),
            snakeGame ?? Text("Not initialized"),
          ],
        ),
      ),
    );
  }
}
