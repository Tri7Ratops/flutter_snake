import 'package:equatable/equatable.dart';
import 'package:flutter_snake/widgets/snake/snake.dart';

//ignore: must_be_immutable
class SnakeGameCase extends Equatable {
  CASE_TYPE? type;

  SnakeGameCase({
    this.type,
  });

  @override
  List<Object?> get props => [
        type,
      ];
}
