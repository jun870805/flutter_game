import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'start_game.dart';

class Joystick extends JoystickComponent {
  /// 搖桿控制
  Joystick(StartGame _game)
      : super(
          margin: const EdgeInsets.only(left: 20, bottom: 20),
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
