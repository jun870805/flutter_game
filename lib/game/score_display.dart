import 'package:flame/components.dart';
import 'flutter_game.dart';

class ScoreDisplay extends TextBoxComponent {
  late FlutterGame game;

  /// 計分板
  ScoreDisplay(_game)
      : super(
          boxConfig: TextBoxConfig(
            timePerChar: 0.1,
          ),
          position: Vector2(0, 0),
        ) {
    game = _game;
  }

  @override
  void update(double dt) {
    if (text != game.score.toString()) {
      text = 'Score : ' + game.score.toString();
      redraw();
    }
    super.update(dt);
  }
}
