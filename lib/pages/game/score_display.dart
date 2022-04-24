import 'package:flame/components.dart';
import 'doodle_game.dart';

class ScoreDisplay extends TextBoxComponent {
  late final DoodleGame _game;

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
  Future<void> onLoad() async {
    await super.onLoad();
    // 遊戲分數初始化
    _game.score = 0;
  }

  @override
  void update(double dt) {
    // 當分數變動時
    if (text != _game.score.toString()) {
      text = 'Score : ' + _game.score.toString();
      // 重新繪製分數物件
      redraw();
    }
    super.update(dt);
  }
}
