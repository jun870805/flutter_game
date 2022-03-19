import 'package:flame/components.dart';
import './start_game.dart';

class ScoreDisplay extends TextBoxComponent {
  late StartGame game;

  /// 計分板
  ScoreDisplay(_game)
      : super(
          boxConfig: TextBoxConfig(
            timePerChar: 0.1,
          ),
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
