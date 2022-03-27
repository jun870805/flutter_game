import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/services.dart';

import 'flutter_game.dart';

// Collidable 碰撞偵測
class Player extends SpriteComponent with HasHitboxes, Collidable {
  late final FlutterGame _game;
  bool _up = false;
  bool _down = false;
  bool _left = false;
  bool _right = true;
  final JoystickComponent _joystick;

  /// 玩家
  Player(this._game, this._joystick)
      : super(
          sprite: Sprite(_game.images.fromCache('player.png')),
          size: Vector2(64, 64),
          position: Vector2(_game.screenWidth / 2, _game.screenHeight / 2),
        ) {
    addHitbox(HitboxCircle());
  }

  // player 移動速度 (根據分數調整難度)
  double _playerSpeed() {
    return 150 * (1 + _game.score / 50);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 自動移動
    if (_up) {
      y -= dt * _playerSpeed();
    }
    if (_down) {
      y += dt * _playerSpeed();
    }
    if (_left) {
      x -= dt * _playerSpeed();
    }
    if (_right) {
      x += dt * _playerSpeed();
    }

    // 搖桿控制
    if (!_joystick.delta.isZero()) {
      // 判斷搖桿移動X軸和Y軸哪個多
      if (_joystick.relativeDelta[0].abs() > _joystick.relativeDelta[1].abs()) {
        // 手動移動
        // x += joystick.relativeDelta[0] * _xSpeed * dt;
        // 判斷向左還向右
        _up = false;
        _down = false;
        if (_joystick.relativeDelta[0] > 0) {
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
        // y += joystick.relativeDelta[1] * _ySpeed * dt;
        // 判斷向上還向下
        _left = false;
        _right = false;
        if (_joystick.relativeDelta[1] > 0) {
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

    // 邊緣碰觸事件
    // 左方邊緣
    if (x < 32) {
      x = _game.screenWidth - 32;
    }
    // 右方邊緣
    if (x > _game.screenWidth - 32) {
      x = 32;
    }
    // 上方邊緣
    if (y < 32) {
      y = _game.screenHeight - 32;
    }
    // 下方邊緣
    if (y > _game.screenHeight - 32) {
      y = 32;
    }

    // 鍵盤事件
    if (_game.keyboard != null) {
      if (_game.keyboard == LogicalKeyboardKey.arrowDown) {
        _left = false;
        _right = false;
        _up = false;
        _down = true;
        angle = pi / 2;
      }
      if (_game.keyboard == LogicalKeyboardKey.arrowUp) {
        _left = false;
        _right = false;
        _up = true;
        _down = false;
        angle = pi * 3 / 2;
      }
      if (_game.keyboard == LogicalKeyboardKey.arrowLeft) {
        _left = true;
        _right = false;
        _up = false;
        _down = false;
        angle = pi;
      }
      if (_game.keyboard == LogicalKeyboardKey.arrowRight) {
        _left = false;
        _right = true;
        _up = false;
        _down = false;
        angle = 0;
      }
    }
  }
}
