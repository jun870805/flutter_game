// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'player.dart';
import 'start_game.dart';

// Collidable 碰撞偵測
class Star extends SpriteComponent with HasHitboxes, Collidable {
  final Random _rnd = Random();
  bool _collision = false;

  final double _starWidth = 60;
  final double _starHeight = 71;

  late StartGame game;

  /// 星星
  Star(_game)
      : super(
          sprite: Sprite(_game.images.fromCache('star.png')),
        ) {
    position = getNewStarPosition();
    addHitbox(HitboxCircle());
    game = _game;
  }

  // 星星隨機生成位置，只能完整出現在螢幕上
  Vector2 getNewStarPosition() {
    StartGame _game = StartGame();
    double x = _rnd.nextDouble() * _game.screenWidth;
    double y = _rnd.nextDouble() * _game.screenHeight;
    while (x < _starWidth || x > _game.screenWidth - _starWidth) {
      x = _rnd.nextDouble() * _game.screenWidth;
      print(x);
    }
    while (y < _starHeight || y > _game.screenHeight - _starHeight) {
      y = _rnd.nextDouble() * _game.screenHeight;
    }
    return Vector2(x, y);
  }

  @override
  void update(double dt) {
    if (_collision) {
      position = getNewStarPosition();
      _collision = false;
      game.score++;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      _collision = true;
    }
  }
}
