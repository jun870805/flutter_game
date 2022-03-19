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

  // @override
  // void drawBackground(Canvas c) {
  //   Rect rect = Rect.fromLTWH(0, 0, width, height);
  //   c.drawRect(rect, Paint()..color = const Color(0xFFFF00FF));
  //   c.drawRect(
  //     rect.deflate(1),
  //     Paint()
  //       ..color = BasicPalette.black.color
  //       ..style = PaintingStyle.stroke,
  //   );
  // }

  @override
  void update(double dt) {
    if (text != game.score.toString()) {
      text = 'Score : ' + game.score.toString();
      redraw();
    }
    super.update(dt);
  }
}
