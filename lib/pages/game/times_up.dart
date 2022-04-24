import 'package:flame/components.dart';

import 'doodle_game.dart';

class TimesUp extends SpriteComponent {
  late final DoodleGame _game;

  /// 時間到
  TimesUp(this._game)
      : super(
          sprite: Sprite(_game.images.fromCache('times_up.png')),
          size: Vector2(300, 200),
          position: Vector2(
              _game.screenWidth / 2 - 150, _game.screenHeight / 2 - 100),
        );
}
