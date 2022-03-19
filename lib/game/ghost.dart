// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'player.dart';
import 'flutter_game.dart';
import 'star.dart';

// Collidable 碰撞偵測
class Ghost extends SpriteComponent with HasHitboxes, Collidable {
  final Random _rnd = Random();
  bool _collision = false;

  final double _ghostWidth = 64;
  final double _ghostHeight = 64;

  late FlutterGame game;

  /// 星星
  Ghost(_game)
      : super(
          sprite: Sprite(_game.images.fromCache('ghost.png')),
          size: Vector2(64, 64),
        ) {
    position = getNewStarPosition();
    addHitbox(HitboxCircle());
    game = _game;
  }

  // 星星隨機生成位置，只能完整出現在螢幕上
  Vector2 getNewStarPosition() {
    FlutterGame _game = FlutterGame();
    double x = _rnd.nextDouble() * _game.screenWidth;
    double y = _rnd.nextDouble() * _game.screenHeight;
    while (x < _ghostWidth || x > _game.screenWidth - _ghostWidth) {
      x = _rnd.nextDouble() * _game.screenWidth;
      print(x);
    }
    while (y < _ghostHeight || y > _game.screenHeight - _ghostHeight) {
      y = _rnd.nextDouble() * _game.screenHeight;
    }
    return Vector2(x, y);
  }

  @override
  void update(double dt) {
    if (_collision) {
      game.status = GameStatus.lose;
      game.changeStatus = true;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // 鬼跟星星不能同位置
    if (other is Star) {
      getNewStarPosition();
    }
    // 玩家撞到鬼
    if (other is Player) {
      _collision = true;
    }
  }
}
