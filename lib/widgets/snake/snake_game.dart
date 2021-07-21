import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';
import 'package:flutter_snake/widgets/snake/snake_board.dart';
import 'package:flutter_snake/widgets/snake/snake_enums/game_event.dart';
import 'package:flutter_snake/widgets/snake/utils/board_case.dart';
import 'package:flutter_snake/widgets/snake/utils/snake_part.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SnakeGame extends StatefulWidget {
  SNAKE_MOVE? _direction;
  double caseWidth;
  Duration durationBetweenTicks;

  set nextDirection(SNAKE_MOVE move) => _direction = move;

  SNAKE_MOVE get getDirection => _direction ?? SNAKE_MOVE.front;

  final int numberCaseHorizontally;
  final int numberCaseVertically;
  final StreamController<GAME_EVENT>? controllerEvent;

  final Color colorBackground1;
  final Color colorBackground2;
  final Color snakeColor;
  final Color foodColor;

  final String? snakeSVGHead;
  final String? snakeSVGBody;
  final String? snakeSVGBodyTurn;
  final String? snakeSVGTail;
  final String? snakeSVGFruit;

  SnakeGame({
    Key? key,
    required this.caseWidth,
    required this.numberCaseHorizontally,
    required this.numberCaseVertically,
    this.durationBetweenTicks = const Duration(milliseconds: 500),
    this.controllerEvent,
    this.colorBackground1 = Colors.greenAccent,
    this.colorBackground2 = Colors.green,
    this.foodColor = Colors.red,
    this.snakeColor = Colors.black,
    this.snakeSVGHead = "assets/default_snake_head.svg",
    this.snakeSVGBody = "assets/default_snake_body.svg",
    this.snakeSVGBodyTurn = "assets/default_snake_turn.svg",
    this.snakeSVGTail = "assets/default_snake_tail.svg",
    this.snakeSVGFruit = "assets/default_snake_fruit.svg",
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
      _moveSnake(value);
    });

    timer = Timer.periodic(widget.durationBetweenTicks, (Timer t) {
      controller?.add(widget.getDirection);
      widget.nextDirection = SNAKE_MOVE.front;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _moveSnake(SNAKE_MOVE direction) {
    GAME_EVENT? event = _board?.moveSnake(direction);
    setState(() {});
    if (event != null) {
      widget.controllerEvent?.add(event);
      if (event == GAME_EVENT.win || event == GAME_EVENT.hit_his_tail || event == GAME_EVENT.out_of_map) {
        timer?.cancel();
        timer = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: widget.caseWidth * widget.numberCaseHorizontally,
      height: widget.caseWidth * widget.numberCaseVertically,
      child: _printBoard(),
    );
  }

  Column _printBoard() {
    List<Widget> items = [];
    int y = 0;
    int x = 0;

    while (_board?.getLine(y) != null) {
      List<Widget> tmp = [];
      x = 0;
      BoardCase? boardCase = _board?.getCase(y, x);

      while (boardCase != null) {
        Color? colorCase;
        String? svgIcon;
        int quarterTurns = 0;
        colorCase = (x % 2 == 0 && y % 2 == 0) || (x % 2 == 1 && y % 2 == 1) ? widget.colorBackground1 : widget.colorBackground2;
        switch (boardCase.caseType) {
          case CASE_TYPE.food:
            svgIcon = widget.snakeSVGFruit;
            if (svgIcon == null) colorCase = widget.foodColor;
            break;
          default:
        }
        if (boardCase.partSnake != null) {
          switch (boardCase.partSnake!.type) {
            case SNAKE_BODY.head:
              svgIcon = widget.snakeSVGHead;
              quarterTurns = _rotateHead(boardCase.partSnake!);
              if (svgIcon == null) colorCase = widget.snakeColor;
              break;
            case SNAKE_BODY.tail:
              svgIcon = widget.snakeSVGTail;
              quarterTurns = _rotateTail(boardCase.partSnake!);
              if (svgIcon == null) colorCase = widget.snakeColor;
              break;
            default:
              if (boardCase.partSnake!.previous!.posX == boardCase.partSnake!.next!.posX ||
                  boardCase.partSnake!.previous!.posY == boardCase.partSnake!.next!.posY) {
                quarterTurns = _rotateBody(boardCase.partSnake!);
                svgIcon = widget.snakeSVGBody;
              } else {
                quarterTurns = _rotateBodyTurn(boardCase.partSnake!);
                svgIcon = widget.snakeSVGBodyTurn;
              }
              if (svgIcon == null) {
                colorCase = widget.snakeColor;
              }
          }
        }
        tmp.add(
          Stack(
            children: [
              Container(
                width: widget.caseWidth,
                height: widget.caseWidth,
                color: colorCase,
              ),
              (svgIcon != null)
                  ? RotatedBox(
                      quarterTurns: quarterTurns,
                      child: SvgPicture.asset(
                        svgIcon,
                        width: widget.caseWidth,
                        height: widget.caseWidth,
                      ),
                    )
                  : Container(),
            ],
          ),
        );
        x++;
        boardCase = _board?.getCase(y, x);
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

  int _rotateHead(SnakePart partSnake) {
    if (partSnake.next!.posX == partSnake.posX) {
      if (partSnake.next!.posY < partSnake.posY) {
        return 3;
      } else {
        return 1;
      }
    } else {
      if (partSnake.next!.posX < partSnake.posX) {
        return 2;
      } else {
        return 0;
      }
    }
  }

  int _rotateTail(SnakePart partSnake) {
    if (partSnake.previous!.posX == partSnake.posX) {
      if (partSnake.previous!.posY < partSnake.posY) {
        return 0;
      } else {
        return 2;
      }
    } else {
      if (partSnake.previous!.posX < partSnake.posX) {
        return 3;
      } else {
        return 1;
      }
    }
  }

  int _rotateBody(SnakePart partSnake) {
    if (partSnake.previous!.posX == partSnake.posX) {
      return 1;
    } else {
      return 0;
    }
  }

  int _rotateBodyTurn(SnakePart partSnake) {
    SnakePart previous = partSnake.previous!;
    SnakePart next = partSnake.next!;

    SNAKE_DIRECTION directionPrevious = _rotateBodyTurnCheckDirection(partSnake, previous);
    SNAKE_DIRECTION directionNext = _rotateBodyTurnCheckDirection(partSnake, next);

    if (directionNext == SNAKE_DIRECTION.down && directionPrevious == SNAKE_DIRECTION.right) {
      return 1;
    }
    if (directionNext == SNAKE_DIRECTION.down && directionPrevious == SNAKE_DIRECTION.left) {
      return 2;
    }
    if (directionNext == SNAKE_DIRECTION.up && directionPrevious == SNAKE_DIRECTION.left) {
      return 3;
    }
    if (directionNext == SNAKE_DIRECTION.left && directionPrevious == SNAKE_DIRECTION.up) {
      return 3;
    }
    if (directionNext == SNAKE_DIRECTION.left && directionPrevious == SNAKE_DIRECTION.down) {
      return 2;
    }
    if (directionNext == SNAKE_DIRECTION.right && directionPrevious == SNAKE_DIRECTION.down) {
      return 1;
    }
    return 0;
  }

  SNAKE_DIRECTION _rotateBodyTurnCheckDirection(SnakePart partSnake, SnakePart compare) {
    if (compare.posX == partSnake.posX) {
      if (compare.posY < partSnake.posY) {
        return SNAKE_DIRECTION.down;
      } else {
        return SNAKE_DIRECTION.up;
      }
    } else {
      if (compare.posX < partSnake.posX) {
        return SNAKE_DIRECTION.right;
      } else {
        return SNAKE_DIRECTION.left;
      }
    }
  }
}
