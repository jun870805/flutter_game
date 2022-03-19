import 'package:flame/components.dart';
import 'flutter_game.dart';

class StartGame extends SpriteComponent {
  late FlutterGame game;

  /// 開始按鈕
  StartGame(_game)
      : super(
          sprite: Sprite(_game.images.fromCache('start.png')),
          size: Vector2(200, 200),
          position: Vector2(
              _game.screenWidth / 2 - 100, _game.screenHeight / 2 - 100),
        ) {
    game = _game;
  }
}
