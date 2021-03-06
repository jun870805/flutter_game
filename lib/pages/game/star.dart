// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import './ghost.dart';

import 'player.dart';
import 'doodle_game.dart';

// Collidable 碰撞偵測
class Star extends SpriteComponent with HasHitboxes, Collidable {
  final Random _rnd = Random();
  bool _collision = false;

  final double _starWidth = 60;
  final double _starHeight = 71;

  late final DoodleGame _game;

  /// 星星
  Star(this._game)
      : super(
          sprite: Sprite(_game.images.fromCache('star.png')),
          size: Vector2(60, 71),
        ) {
    position = getNewStarPosition();
    addHitbox(HitboxCircle());
  }

  // 星星隨機生成位置，只能完整出現在螢幕上
  Vector2 getNewStarPosition() {
    double x = _rnd.nextDouble() * _game.screenWidth;
    double y = _rnd.nextDouble() * _game.screenHeight;
    while (x < _starWidth || x > _game.screenWidth - _starWidth) {
      x = _rnd.nextDouble() * _game.screenWidth;
    }
    while (y < _starHeight || y > _game.screenHeight - _starHeight) {
      y = _rnd.nextDouble() * _game.screenHeight;
    }
    return Vector2(x, y);
  }

  @override
  void update(double dt) {
    if (_collision) {
      // 星星變換新位置
      position = getNewStarPosition();
      _collision = false;
      // 分數 +1
      _game.score++;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // 鬼跟星星不能同位置
    if (other is Ghost) {
      getNewStarPosition();
    }
    // 當玩家與星星產生接觸
    if (other is Player) {
      _collision = true;
    }
  }
}
