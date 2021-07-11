import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';
import 'package:flutter_snake/widgets/snake/utils/board_case.dart';
import 'package:flutter_snake/widgets/snake/utils/snake_part.dart';

class SnakeBoard {
  List<List<BoardCase>> _board = [];
  late SnakePart _snake;

  final BuildContext context;
  final int numberCaseHorizontally;
  final int numberCaseVertically;

  SnakeBoard({
    required this.context,
    required this.numberCaseHorizontally,
    required this.numberCaseVertically,
  }) {
    _initBoard();
    _snake = new SnakePart(type: SNAKE_BODY.head, posY: numberCaseVertically ~/ 2, posX: 3);
    _snake.next = new SnakePart(type: SNAKE_BODY.body, posY: numberCaseVertically ~/ 2, posX: 2);
    _snake.next!.next = new SnakePart(type: SNAKE_BODY.tail, posY: numberCaseVertically ~/ 2, posX: 1);
    _updateBoard();
  }

  moveSnake(SNAKE_MOVE move) {}

  _updateBoard() {
    for (List<BoardCase> boardLine in _board) {
      for (BoardCase boardCase in boardLine) {
        boardCase.partSnake = null;
      }
    }
    SnakePart? snakeTmp = _snake;
    while (snakeTmp != null) {
      print("${snakeTmp.type}: [${snakeTmp.posY}][${snakeTmp.posX}]");
      _board[snakeTmp.posY][snakeTmp.posX].partSnake = snakeTmp;
      snakeTmp = snakeTmp.next;
    }
    print("----------------------------------");
  }

  _initBoard() {
    int x = 0;
    int y = 0;

    while (y < this.numberCaseVertically) {
      x = 0;
      _board.add([]);
      while (x < this.numberCaseHorizontally) {
        _board[y].add(BoardCase());
        x++;
      }
      y++;
    }
  }

  BoardCase? getCase(int y, int x) {
    try {
      return _board[y][x];
    } catch (e) {
  //    print("SNAKE BOARD: OUT OF THE BOARD [$y][$x]");
      return null;
    }
  }

  List<BoardCase>? getLine(int index) {
    try {
      return _board[index];
    } catch (e) {
     // print("SNAKE BOARD: OUT OF THE BOARD");
      return null;
    }
  }

  List<List<BoardCase>> get board => _board;
}
