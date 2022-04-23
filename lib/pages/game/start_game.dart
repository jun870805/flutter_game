import 'package:flame/components.dart';
import 'game.dart';

class StartGame extends SpriteComponent {
  late final DoodleGame _game;

  /// 開始
  StartGame(this._game)
      : super(
          sprite: Sprite(_game.images.fromCache('start.png')),
          size: Vector2(200, 200),
          position: Vector2(
              _game.screenWidth / 2 - 100, _game.screenHeight / 2 - 100),
        );
}
