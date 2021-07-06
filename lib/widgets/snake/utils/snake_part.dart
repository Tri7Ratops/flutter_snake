import 'package:flutter_snake/widgets/snake/snake_enums/snake_body.dart';

class SnakePart {
  SNAKE_BODY type;
  int posY;
  int posX;
  
  SnakePart? next;
  SnakePart? previous;

  SnakePart({required this.type, required this.posY, required this.posX});
}