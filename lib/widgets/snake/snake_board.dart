import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';
import 'package:flutter_snake/widgets/snake/utils/board_case.dart';
import 'package:flutter_snake/widgets/snake/utils/snake_part.dart';

class SnakeBoard {
  List<List<BoardCase>> _board = [];
  late SnakePart _snake;
  late SnakePart _tail;

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
    _snake.next = new SnakePart(type: SNAKE_BODY.body, posY: numberCaseVertically ~/ 2, posX: 2, previous: _snake);
    _snake.next!.next = new SnakePart(type: SNAKE_BODY.tail, posY: numberCaseVertically ~/ 2, posX: 1, previous: _snake.next!);
    _tail = _snake.next!.next!;
    _updateBoard();
  }

  _snakeMoveRight(SNAKE_DIRECTION direction) {

  }

  _snakeMoveLeft(SNAKE_DIRECTION direction) {

  }

  _snakeMoveFront(SNAKE_DIRECTION direction) {

    SnakePart? snakeTmp = _tail;
    while (snakeTmp?.previous != null) {
      snakeTmp!.posX = snakeTmp.previous!.posX;
      snakeTmp.posY = snakeTmp.previous!.posY;
      snakeTmp = snakeTmp.previous;
    }
    switch (direction) {
      case SNAKE_DIRECTION.left:
        _snake.posX--;
        break;
      case SNAKE_DIRECTION.right:
        _snake.posX++;
        break;
      case SNAKE_DIRECTION.up:
        _snake.posY--;
        break;
      case SNAKE_DIRECTION.down:
        _snake.posY++;
        break;
    }
  }

  moveSnake(SNAKE_MOVE move) {
    SNAKE_DIRECTION direction;
    if (_snake.next!.posX == _snake.posX) {
      // VERTICAL
      if (_snake.next!.posY < _snake.posY) {
        direction = SNAKE_DIRECTION.down;
        // TO BOTTOM
      } else {
        direction = SNAKE_DIRECTION.up;
        // TO UP
      }
    } else {
      // HORIZONTAL
      if (_snake.next!.posX < _snake.posX) {
        // TO RIGHT
        direction = SNAKE_DIRECTION.right;
      } else {
        // TO LEFT
        direction = SNAKE_DIRECTION.left;
      }
    }
    if (move == SNAKE_MOVE.right) {
      _snakeMoveRight(direction);
    } else if (move == SNAKE_MOVE.left) {
      _snakeMoveLeft(direction);
    } else {
      _snakeMoveFront(direction);
    }
    _updateBoard();
  }

  _updateBoard() {
    for (List<BoardCase> boardLine in _board) {
      for (BoardCase boardCase in boardLine) {
        boardCase.partSnake = null;
      }
    }
    SnakePart? snakeTmp = _snake;
    while (snakeTmp != null && getCase(snakeTmp.posY, snakeTmp.posX) != null) {
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
