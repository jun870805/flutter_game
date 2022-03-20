import 'package:flame/components.dart';
import 'flutter_game.dart';

class ScoreDisplay extends TextBoxComponent {
  late final FlutterGame _game;

  /// 計分板
  ScoreDisplay(this._game)
      : super(
          boxConfig: TextBoxConfig(
            timePerChar: 0.1,
            maxWidth: 140,
          ),
          position: Vector2(
              _game.screenWidth / 2 - 60, _game.screenHeight * (2 / 10)),
        );

  @override
  void update(double dt) {
    if (text != _game.score.toString()) {
      text = 'Score : ' + _game.score.toString();
      redraw();
    }
    super.update(dt);
  }
}
