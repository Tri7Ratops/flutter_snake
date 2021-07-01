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

  SnakeGameCase? getCase(int y, int x) {
    try {
      return _board[y][x];
    } catch (e) {
      return null;
    }
  }

  List<SnakeGameCase>? getLine(int index) {
    try {
      return _board[index];
    } catch (e) {
      return null;
    }
  }

  List<List<SnakeGameCase>> get board => _board;
}
