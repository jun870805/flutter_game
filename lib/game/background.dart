import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'flutter_game.dart';
import 'dart:ui';

class Background extends RectangleComponent with Tappable {
  late FlutterGame game;

  /// 背景
  Background(FlutterGame _game)
      : super(
          size: Vector2(_game.screenHeight, _game.screenHeight),
          position: Vector2(0, 0),
          paint: BasicPalette.black.paint()..style = PaintingStyle.fill,
        ) {
    game = _game;
  }

  // 遊戲點擊事件流程
  @override
  bool onTapDown(TapDownInfo info) {
    if (!game.changeStatus) {
      if (game.status == GameStatus.start) {
        game.status = GameStatus.play;
        game.changeStatus = true;
      }
      if (game.status == GameStatus.timesUp) {
        game.status = GameStatus.start;
        game.changeStatus = true;
      }
    }
    return true;
  }
}
