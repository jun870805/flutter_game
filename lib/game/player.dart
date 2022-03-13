import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'start_game.dart';

// Collidable 碰撞偵測
class Player extends SpriteComponent with HasHitboxes, Collidable {
  late final StartGame _game;
  bool _up = false;
  bool _down = false;
  bool _left = false;
  bool _right = true;
  final double ySpeed = 300;
  final double xSpeed = 300;
  final JoystickComponent joystick;

  /// 玩家
  Player(this._game, this.joystick)
      : super(
          sprite: Sprite(_game.images.fromCache('player.png')),
          size: Vector2(64, 64),
          position: Vector2(_game.screenWidth / 2, _game.screenHeight / 2),
        ) {
    addHitbox(HitboxCircle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 自動移動
    if (_up) {
      y -= dt * ySpeed;
    }
    if (_down) {
      y += dt * ySpeed;
    }
    if (_left) {
      x -= dt * xSpeed;
    }
    if (_right) {
      x += dt * xSpeed;
    }

    // 搖桿控制
    if (!joystick.delta.isZero()) {
      //判斷搖桿移動X軸和Y軸哪個多
      if (joystick.relativeDelta[0].abs() > joystick.relativeDelta[1].abs()) {
        // 手動移動
        // x += joystick.relativeDelta[0] * xSpeed * dt;
        //判斷向左還向右
        _up = false;
        _down = false;
        if (joystick.relativeDelta[0] > 0) {
          angle = 0;
          _left = false;
          _right = true;
        } else {
          angle = pi;
          _left = true;
          _right = false;
        }
      } else {
        // 手動移動
        // y += joystick.relativeDelta[1] * ySpeed * dt;
        //判斷向上還向下
        _left = false;
        _right = false;
        if (joystick.relativeDelta[1] > 0) {
          angle = pi / 2;
          _up = false;
          _down = true;
        } else {
          angle = pi * 3 / 2;
          _up = true;
          _down = false;
        }
      }
    }

    // 左方邊緣碰撞
    if (x < 32) {
      x = _game.screenWidth - 32;
    }
    // 右方邊緣碰撞
    if (x > _game.screenWidth - 32) {
      x = 32;
    }
    // 上方邊緣碰撞
    if (y < 32) {
      y = _game.screenHeight - 32;
    }
    // 下方邊緣碰撞
    if (y > _game.screenHeight - 32) {
      y = 32;
    }
  }
}
