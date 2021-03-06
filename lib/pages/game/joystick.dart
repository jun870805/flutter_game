import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'doodle_game.dart';

class Joystick extends JoystickComponent {
  late final DoodleGame _game;

  /// 搖桿控制
  Joystick(this._game)
      : super(
          margin: const EdgeInsets.only(right: 20, bottom: 20),
          knob: SpriteComponent(
            sprite: SpriteSheet.fromColumnsAndRows(
              image: _game.images.fromCache('joystick.png'),
              columns: 6,
              rows: 1,
            ).getSpriteById(1),
            size: Vector2.all(50),
          ),
          background: SpriteComponent(
            sprite: SpriteSheet.fromColumnsAndRows(
              image: _game.images.fromCache('joystick.png'),
              columns: 6,
              rows: 1,
            ).getSpriteById(0),
            size: Vector2.all(75),
          ),
        );
}
