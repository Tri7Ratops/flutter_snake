import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';
import 'package:flutter_snake/widgets/snake/snake_board.dart';

class SnakeGame extends StatefulWidget {
  SNAKE_MOVE? _direction;

  set nextDirection(SNAKE_MOVE move) => _direction = move;
  SNAKE_MOVE get getDirection => _direction ?? SNAKE_MOVE.front;

  final double caseWidth;
  final int numberCaseHorizontally;
  final int numberCaseVertically;
  final Duration durationBetweenTicks;
  final Color borderColor;
  final Color backgroundColor;

  SnakeGame({
    Key? key,
    required this.caseWidth,
    required this.numberCaseHorizontally,
    required this.numberCaseVertically,
    this.durationBetweenTicks = const Duration(seconds: 1),
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.grey,
  }) : super(
          key: key,
        ) {
    if (numberCaseVertically < 10 || numberCaseHorizontally < 10) {
      throw ("Error SnakeGame: numberCaseVertically and numberCaseHorizontally can't be inferior of 10");
    }
  }

  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  StreamController<SNAKE_MOVE>? controller;
  SnakeBoard? _board;
  Timer? timer;

  String? debugMove;

  @override
  void initState() {
    super.initState();

    _board = SnakeBoard(
      context: context,
      numberCaseHorizontally: widget.numberCaseHorizontally,
      numberCaseVertically: widget.numberCaseVertically,
    );
    if (controller == null) {
      controller = StreamController<SNAKE_MOVE>();
    }
    controller?.stream.listen((value) {
      print("CONTROLLER LISTEN");
      _moveSnake(value);
    });

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      print("TIMER !: [${widget.getDirection}]");
      print("widget.controller is null: ${controller == null}");
      controller?.add(widget.getDirection);
      widget.nextDirection = SNAKE_MOVE.front;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _moveSnake(SNAKE_MOVE event) {
    debugMove = "move $event";
    print("=== MOVE :");
    print("EVENT: $event");
    _board?.moveSnake(event);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(debugMove ?? "No move"),
        Container(
          color: widget.backgroundColor,
          width: widget.caseWidth * widget.numberCaseHorizontally,
          height: widget.caseWidth * widget.numberCaseVertically,
          child: _printBoard(),
        ),
      ],
    );
  }

  Column _printBoard() {
    List<Widget> items = [];
    int y = 0;
    int x = 0;

    while (_board?.getLine(y) != null) {
      List<Widget> tmp = [];
      x = 0;
      while (_board?.getCase(y, x) != null) {
        tmp.add(
          Container(
            width: widget.caseWidth,
            height: widget.caseWidth,
            color: Colors.orange,
          ),
        );
        x++;
      }
      items.add(
        Row(
          children: tmp,
        ),
      );

      y++;
    }

    return Column(
      children: items,
    );
  }
}
