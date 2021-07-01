import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake_board.dart';

import 'snake_game_case.dart';

class SnakeGame extends StatefulWidget {
  final double caseWidth;
  final int numberCaseHorizontally;
  final int numberCaseVertically;
  final Duration durationBetweenTicks;
  final Color borderColor;
  final Color backgroundColor;

  SnakeGame(
      {Key? key,
      required this.caseWidth,
      required this.numberCaseHorizontally,
      required this.numberCaseVertically,
      this.durationBetweenTicks = const Duration(seconds: 1),
      this.borderColor = Colors.black,
      this.backgroundColor = Colors.grey})
      : super(
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
  late final SnakeBoard _board;

  @override
  void initState() {
    super.initState();

    _board = SnakeBoard(
      context: context,
      numberCaseHorizontally: widget.numberCaseHorizontally,
      numberCaseVertically: widget.numberCaseVertically,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      width: widget.caseWidth * widget.numberCaseHorizontally,
      height: widget.caseWidth * widget.numberCaseVertically,
      child: _printBoard(),
    );
  }

  Column _printBoard() {
    List<Widget> items = [];
    int y = 0;
    int x = 0;

    while (_board.getLine(y) != null) {
      List<Widget> tmp = [];
      x = 0;
      while (_board.getCase(y, x) != null) {
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
