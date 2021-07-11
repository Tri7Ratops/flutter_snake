import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';

class SnakeBoard {
  List<List<CASE_TYPE>> _board = [];

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

  moveSnake(SNAKE_MOVE move) {

  }

  _initBoard() {
    int x = 0;
    int y = 0;

    while (y < this.numberCaseVertically) {
      x = 0;
      _board.add([]);
      while (x < this.numberCaseHorizontally) {
        _board[y].add(CASE_TYPE.empty);
        x++;
      }
      y++;
    }
  }

  CASE_TYPE? getCase(int y, int x) {
    try {
      return _board[y][x];
    } catch (e) {
      print("SNAKE BOARD: OUT OF THE BOARD [$y][$x]");
      return null;
    }
  }

  List<CASE_TYPE>? getLine(int index) {
    try {
      return _board[index];
    } catch (e) {
      print("SNAKE BOARD: OUT OF THE BOARD");
      return null;
    }
  }

  List<List<CASE_TYPE>> get board => _board;
}
