# flutter_snake

This package provides a way to have a game of snake in his app' !

<table>
  <thead>
    <tr>
        <th>Snake in game</th>
        <th>Big snake</th>
        <th>Little snake</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>
            <img src="https://raw.githubusercontent.com/Tri7Ratops/flutter_snake/master/documentation/snake_game.gif" alt="A gif showing the snake in movement" />
        </td>
        <td>
            <img src="https://raw.githubusercontent.com/Tri7Ratops/flutter_snake/master/documentation/big_snake.png" alt="A big snake" />
        </td>
        <td>
            <img src="https://raw.githubusercontent.com/Tri7Ratops/flutter_snake/master/documentation/little_snake.png" alt="A little snake" />
        </td>
    </tr>
  </tbody>
</table>

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  flutter_snake: any
```

In your library add the following import:

```dart
import 'package:flutter_snake/flutter_snake.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Usage

First, define the `SnakeGame`:

```dart
SnakeGame? snakeGame;

@override
  void initState() {
    super.initState();

    // Example:
    snakeGame = new SnakeGame(
      caseWidth: 25.0,
      numberCaseHorizontally: 11,
      numberCaseVertically: 11,
      durationBetweenTicks: Duration(milliseconds: 400),
      colorBackground1: Color(0XFF7CFC00),
      colorBackground2: Color(0XFF32CD32),
    );
  }
```

Then, add the `snakeGame` in your page:

```dart
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: snakeGame ?? Text("Not initialized"),
      ),
    );
  }
```

The snake will start, but he will crash into the wall because we didn't implemented his movement.

For example, you can manage his movement like this :

```dart
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => snakeGame?.nextDirection = SNAKE_MOVE.left, // Define left as the next direction of the snake 
                  icon: Icon(Icons.subdirectory_arrow_left),
                ),
                Text("SNAKE"),
                IconButton(
                  onPressed: () => snakeGame?.nextDirection = SNAKE_MOVE.right, // Define right as the next direction of the snake
                  icon: Icon(Icons.subdirectory_arrow_right),
                ),
              ],
            ),
```

You can also add a `controller` to the `snakeGame` so you can listen to the `GameEvent` (win, loose, food eaten)

```dart
  StreamController<GAME_EVENT>? controller;
  SnakeGame? snakeGame;

  @override
  void initState() {
    super.initState();
    controller = StreamController<GAME_EVENT>();
    controller?.stream.listen((GAME_EVENT value) {
      print(value.toString());
    });

    snakeGame = new SnakeGame(
      caseWidth: 25.0,
      numberCaseHorizontally: 11,
      numberCaseVertically: 11,
      controllerEvent: controller,
      durationBetweenTicks: Duration(milliseconds: 400),
      colorBackground1: Color(0XFF7CFC00),
      colorBackground2: Color(0XFF32CD32),
    );
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }
```


## Customize

### SnakeGame

```dart
  /// Case width / height (It's a square)
  double caseWidth;

  /// Duration between each ticks
  final Duration durationBetweenTicks;

  /// Number of case horizontally (x)
  final int numberCaseHorizontally;

  /// Number of case vertically (y)
  final int numberCaseVertically;

  /// If defines, the controller stream receive the game event
  final StreamController<GAME_EVENT>? controllerEvent;

  /// Color variation for the background
  final Color colorBackground1;
  final Color colorBackground2;

  /// Snake image body and fruit
  final String? snakeHeadImgPath;
  final String? snakeBodyImgPath;
  final String? snakeBodyTurnImgPath;
  final String? snakeTailImgPath;
  final String? snakeFruitImgPath;
```

## Examples

Main example: [example](https://github.com/Tri7Ratops/flutter_snake/tree/master/example)

If you need more example, don't hesitate to ask me ! :)

## FYI

Don't hesitate to report bugs, to ask for more features or participate in the developement :)

## Thanks to

[Gaëlle Bauvin](https://github.com/gaellebauvin) and [Alyssia C](https://github.com/Alyyen) for the snake default sprites ! <3