import 'package:flame/components.dart';

import 'flutter_game.dart';

class Lose extends SpriteComponent {
  late FlutterGame game;

  /// 碰到鬼
  Lose(_game)
      : super(
          sprite: Sprite(_game.images.fromCache('lose.png')),
          size: Vector2(300, 200),
          position: Vector2(
              _game.screenWidth / 2 - 150, _game.screenHeight / 2 - 100),
        ) {
    game = _game;
  }
}
