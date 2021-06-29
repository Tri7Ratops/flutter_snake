import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake_board.dart';

import 'snake_game_case.dart';

class SnakeGame extends StatefulWidget {
  final int caseWidth;
  final int numberCaseHorizontally;
  final int numberCaseVertically;
  final Duration durationBetweenTicks;
  final Color? borderColor;

  SnakeGame({
    Key? key,
    required this.caseWidth,
    required this.numberCaseHorizontally,
    required this.numberCaseVertically,
    this.durationBetweenTicks = const Duration(seconds: 1),
    this.borderColor,
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
      color: Colors.red,
      width: (widget.caseWidth * widget.numberCaseHorizontally).toDouble(),
      height: (widget.caseWidth * widget.numberCaseVertically).toDouble(),
      child: Text("Hey !"),
    );
  }
}
