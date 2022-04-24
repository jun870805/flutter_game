import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'doodle_game.dart';
import 'dart:ui';

class Background extends RectangleComponent with Tappable {
  late final DoodleGame _game;

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
      // 開始頁點擊後的下一步
      if (_game.status == GameStatus.start) {
        _game.status = GameStatus.play;
        _game.changeStatus = true;
      }
      // 時間到點擊後的下一步
      if (_game.status == GameStatus.timesUp) {
        _game.status = GameStatus.start;
        _game.changeStatus = true;
      }
      // 碰到鬼後點擊後的下一步
      if (_game.status == GameStatus.lose) {
        _game.status = GameStatus.start;
        _game.changeStatus = true;
      }
    }
    return true;
  }
}
