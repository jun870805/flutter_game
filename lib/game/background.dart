import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'start_game.dart';
import 'dart:ui';

class Background extends RectangleComponent {
  /// 背景
  Background(StartGame _game)
      : super(
          size: Vector2(_game.screenHeight, _game.screenHeight),
          position: Vector2(0, 0),
          paint: BasicPalette.black.paint()..style = PaintingStyle.fill,
        );
}
