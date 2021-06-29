import 'package:flutter/material.dart';

import 'snake_game_case.dart';

class SnakeBoard {
  List<List<SnakeGameCase>> _board = [];

  final BuildContext context;
  final int numberCaseHorizontally;
  final int numberCaseVertically;

  SnakeBoard({
    required this.context,
    required this.numberCaseHorizontally,
    required this.numberCaseVertically,
  }) {
    _initBoard();
  }

  _initBoard() {
    int x = 0;
    int y = 0;

    while (y < this.numberCaseVertically) {
      x = 0;
      _board.add([]);
      while (x < this.numberCaseHorizontally) {
        _board[y].add(SnakeGameCase());
        x++;
      }
      y++;
    }
  }
}
