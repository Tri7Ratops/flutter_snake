import 'dart:math';

import 'package:flutter_snake/src/snake_enums/snake_enums.dart';
import 'package:flutter_snake/src/utils/utils.dart';

class SnakeBoard {
  /// The board
  final List<List<BoardCase>> _board = [];

  /// Pointer to the snake's head
  late SnakePart _snake;

  /// Pointer to snake's tail
  late SnakePart _tail;

  /// Number of case horizontally (x)
  final int numberCaseHorizontally;

  /// Number of case horizontally (y)
  final int numberCaseVertically;

  /// is Lava (fire cell) enabled
  final bool isLavaEnabled;

  /// Limit of lava (fire cells) that can be appeared on the board
  final int limitLavaBoard;

  /// First number of food eaten cases that lava (fire cells) not appears
  final int numberCaseNoLava;

  int currentIndex = 0;

  final List<CASE_TYPE> foodList;

  int eatFoodCount = 0;

  SnakeBoard({
    required this.numberCaseHorizontally,
    required this.numberCaseVertically,
    required this.foodList,
    this.isLavaEnabled = false,
    this.limitLavaBoard = 26,
    this.numberCaseNoLava = 3,
  }) {
    /// Instanciate the board
    _initBoard();

    /// Create the snake
    _snake = new SnakePart(
      type: SNAKE_BODY.head,
      posY: numberCaseVertically ~/ 2,
      posX: 5,
    );
    _snake.next = new SnakePart(
      type: SNAKE_BODY.body,
      posY: numberCaseVertically ~/ 2,
      posX: 4,
      previous: _snake,
    );
    _snake.next!.next = new SnakePart(
      type: SNAKE_BODY.body,
      posY: numberCaseVertically ~/ 2,
      posX: 3,
      previous: _snake.next!,
    );
    _snake.next!.next!.next = new SnakePart(
      type: SNAKE_BODY.body,
      posY: numberCaseVertically ~/ 2,
      posX: 2,
      previous: _snake.next!.next!,
    );
    _snake.next!.next!.next!.next = new SnakePart(
      type: SNAKE_BODY.tail,
      posY: numberCaseVertically ~/ 2,
      posX: 1,
      previous: _snake.next!.next!.next!,
    );
    _tail = _snake.next!.next!.next!.next!;

    /// Update the board with the snake
    _updateBoard();
  }

  /// ATTENTION: This is default front movement. Don't use it for control snake
  _snakeMoveFront(SNAKE_DIRECTION direction) {
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

  /// Manage the snake movement on the right
  _snakeMoveRight(SNAKE_DIRECTION direction) {
    switch (direction) {
      case SNAKE_DIRECTION.left:
        _snake.posX--;
        break;
      case SNAKE_DIRECTION.right:
        _snake.posX++;
        break;
      case SNAKE_DIRECTION.up:
        _snake.posX++;
        break;
      case SNAKE_DIRECTION.down:
        _snake.posX++;
        break;
    }
  }

  /// Manage the snake movement on the left
  _snakeMoveLeft(SNAKE_DIRECTION direction) {
    switch (direction) {
      case SNAKE_DIRECTION.left:
        _snake.posX--;
        break;
      case SNAKE_DIRECTION.right:
        _snake.posX++;
        break;
      case SNAKE_DIRECTION.up:
        _snake.posX--;
        break;
      case SNAKE_DIRECTION.down:
        _snake.posX--;
        break;
    }
  }

  /// Manage the snake movement on the up

  _snakeMoveUp(SNAKE_DIRECTION direction) {
    switch (direction) {
      case SNAKE_DIRECTION.left:
        _snake.posY--;
        break;
      case SNAKE_DIRECTION.right:
        _snake.posY--;
        break;
      case SNAKE_DIRECTION.up:
        _snake.posY--;
        break;
      case SNAKE_DIRECTION.down:
        _snake.posY++;
        break;
    }
  }

  /// Manage the snake movement on the down
  _snakeMoveDown(SNAKE_DIRECTION direction) {
    switch (direction) {
      case SNAKE_DIRECTION.left:
        _snake.posY++;
        break;
      case SNAKE_DIRECTION.right:
        _snake.posY++;
        break;
      case SNAKE_DIRECTION.up:
        _snake.posY--;
        break;
      case SNAKE_DIRECTION.down:
        _snake.posY++;
        break;
    }
  }

  /// Manage the snake movement
  GAME_EVENT? moveSnake(SNAKE_MOVE move) {
    GAME_EVENT? event;
    SNAKE_DIRECTION direction;

    /// Check his direction
    if (_snake.next!.posX == _snake.posX) {
      if (_snake.next!.posY < _snake.posY) {
        direction = SNAKE_DIRECTION.down;
      } else {
        direction = SNAKE_DIRECTION.up;
      }
    } else {
      if (_snake.next!.posX < _snake.posX) {
        direction = SNAKE_DIRECTION.right;
      } else {
        direction = SNAKE_DIRECTION.left;
      }
    }
    if (_board[_snake.posY][_snake.posX].caseType == CASE_TYPE.fruit ||
        _board[_snake.posY][_snake.posX].caseType == CASE_TYPE.spin ||
        _board[_snake.posY][_snake.posX].caseType == CASE_TYPE.cash ||
        _board[_snake.posY][_snake.posX].caseType == CASE_TYPE.coin) {
      /// Add a new part of the snake if the head is on a food
      SnakePart newPart = SnakePart(
        type: SNAKE_BODY.body,
        posY: _snake.posY,
        posX: _snake.posX,
        previous: _snake,
        next: _snake.next,
      );
      _snake.next!.previous = newPart;
      _snake.next = newPart;
      switch (_board[_snake.posY][_snake.posX].caseType) {
        case CASE_TYPE.fruit:
          event = GAME_EVENT.fruit_eaten;
          break;
        case CASE_TYPE.cash:
          event = GAME_EVENT.cash_eaten;
          break;
        case CASE_TYPE.coin:
          event = GAME_EVENT.coin_eaten;
          break;
        case CASE_TYPE.spin:
          event = GAME_EVENT.spin_eaten;
          break;
        default:
          break;
      }
    } else {
      /// Move all the snake depends on his previous part
      SnakePart? snakeTmp = _tail;
      while (snakeTmp?.previous != null) {
        snakeTmp!.posX = snakeTmp.previous!.posX;
        snakeTmp.posY = snakeTmp.previous!.posY;
        snakeTmp = snakeTmp.previous;
      }
    }
    if (move == SNAKE_MOVE.right) {
      _snakeMoveRight(direction);
    } else if (move == SNAKE_MOVE.left) {
      _snakeMoveLeft(direction);
    } else if (move == SNAKE_MOVE.up) {
      _snakeMoveUp(direction);
    } else if (move == SNAKE_MOVE.down) {
      _snakeMoveDown(direction);
    } else {
      _snakeMoveFront(direction);
    }

    /// Check if the snake go out of the map
    if (_snake.posX < 0 ||
        _snake.posX >= numberCaseHorizontally ||
        _snake.posY < 0 ||
        _snake.posY >= numberCaseVertically) {
      return GAME_EVENT.out_of_map;
    }

    /// Check if the snake hit his tail and update the board
    return _updateBoard() ?? event;
  }

  /// Update the board
  GAME_EVENT? _updateBoard() {
    bool hitHisTail = false;
    bool touchLava = false;
    for (List<BoardCase> boardLine in _board) {
      for (BoardCase boardCase in boardLine) {
        boardCase.partSnake = null;
      }
    }
    SnakePart? snakeTmp = _snake;
    while (snakeTmp != null && getCase(snakeTmp.posY, snakeTmp.posX) != null) {
      if (_board[snakeTmp.posY][snakeTmp.posX].partSnake != null) {
        hitHisTail = true;
      }
      if (snakeTmp.next == null) {
        _board[snakeTmp.posY][snakeTmp.posX].caseType = CASE_TYPE.empty;
      }
      if (_board[_snake.posY][_snake.posX].caseType == CASE_TYPE.lava) {
        touchLava = true;
      }
      _board[snakeTmp.posY][snakeTmp.posX].partSnake = snakeTmp;
      snakeTmp = snakeTmp.next;
    }
    if (touchLava) {
      return GAME_EVENT.touch_lava;
    }
    return hitHisTail ? GAME_EVENT.hit_his_tail : _manageFood();
  }

  /// Manage the food and his apparition
  _manageFood() {
    List<BoardCase> emptyCases = [];
    int nbFood = 0;

    for (List<BoardCase> boardLine in _board) {
      for (BoardCase boardCase in boardLine) {
        if (boardCase.caseType == CASE_TYPE.empty && boardCase.partSnake == null) {
          emptyCases.add(boardCase);
        } else if ((boardCase.caseType == CASE_TYPE.fruit ||
                boardCase.caseType == CASE_TYPE.spin ||
                boardCase.caseType == CASE_TYPE.cash ||
                boardCase.caseType == CASE_TYPE.coin) &&
            boardCase.partSnake == null) {
          nbFood++;
        }
      }
    }
    if (nbFood == 0) {
      // Increment number of foods(cash, coint, fruit) that snake eats
      eatFoodCount++;

      /// Place a food on a empty case randomly
      var rng = new Random();
      if (foodList.isNotEmpty && currentIndex < foodList.length) {
        emptyCases[rng.nextInt(emptyCases.length)].caseType = foodList[currentIndex];
        currentIndex++;
      } else {
        emptyCases[rng.nextInt(emptyCases.length)].caseType = CASE_TYPE.fruit;
      }
      //
      // Add lava(fire cell) to the board when snake eats every second type of food(cash,coin, fruit)
      // Let the user to collect some foods(cash, coint, fruit) first
      // Set the limit for lava (fire cell) that can be appear on the board
      //
      if (isLavaEnabled && eatFoodCount.isEven && eatFoodCount > numberCaseNoLava && eatFoodCount <= limitLavaBoard) {
        emptyCases[rng.nextInt(emptyCases.length)].caseType = CASE_TYPE.lava;
      }
    }

    if (emptyCases.isEmpty) {
      return GAME_EVENT.hit_his_tail;
    }
  }

  /// Init the board with empty case
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

  /// Get specific case
  BoardCase? getCase(int y, int x) {
    try {
      return _board[y][x];
    } catch (e) {
      return null;
    }
  }

  /// Get specific line
  List<BoardCase>? getLine(int index) {
    try {
      return _board[index];
    } catch (e) {
      return null;
    }
  }

  /// Get the board
  List<List<BoardCase>> get board => _board;
}
