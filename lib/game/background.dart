import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'flutter_game.dart';
import 'dart:ui';

class Background extends RectangleComponent with Tappable {
  late final FlutterGame _game;

  /// 背景
  Background(this._game)
      : super(
          size: Vector2(_game.screenHeight, _game.screenHeight),
          position: Vector2(0, 0),
          paint: BasicPalette.black.paint()..style = PaintingStyle.fill,
        );

  @override
  bool onTapDown(TapDownInfo info) {
    // 遊戲點擊事件流程
    if (!_game.changeStatus) {
      if (_game.status == GameStatus.start) {
        _game.status = GameStatus.play;
        _game.changeStatus = true;
      }
      if (_game.status == GameStatus.timesUp) {
        _game.status = GameStatus.start;
        _game.changeStatus = true;
      }
      if (_game.status == GameStatus.lose) {
        _game.status = GameStatus.start;
        _game.changeStatus = true;
      }
    }
    return true;
  }
}
