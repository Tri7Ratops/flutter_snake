import 'package:flutter_snake/widgets/snake/snake.dart';
import 'package:flutter_snake/widgets/snake/utils/snake_part.dart';

class BoardCase {
  SnakePart? partSnake;
  CASE_TYPE caseType;

  BoardCase({
    this.partSnake,
    this.caseType = CASE_TYPE.empty,
  });
}
