import 'package:flutter_snake/src/snake_enums/case_type.dart';
import 'package:flutter_snake/src/utils/snake_part.dart';

class BoardCase {
  SnakePart? partSnake;
  CASE_TYPE caseType;

  BoardCase({
    this.partSnake,
    this.caseType = CASE_TYPE.empty,
  });
}
