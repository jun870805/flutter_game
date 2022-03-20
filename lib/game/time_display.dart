import 'package:flame/components.dart';
import 'flutter_game.dart';
import 'dart:async' as async;

class TimeDisplay extends TextBoxComponent {
  late final FlutterGame _game;
  late int time;

  /// 計分板
  TimeDisplay(this._game)
      : super(
          boxConfig: TextBoxConfig(
            timePerChar: 0.1,
            maxWidth: 120,
          ),
          position: Vector2(
              _game.screenWidth / 2 - 60, _game.screenHeight * (1 / 10)),
        );

  void timeCountDown() {
    async.Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        time--;
        if (time == 0) {
          _game.status = GameStatus.timesUp;
          _game.changeStatus = true;
          timer.cancel();
        }
      },
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    time = 60;
    timeCountDown();
    // await redraw();
  }

  @override
  void update(double dt) {
    if (text != time.toString() && time >= 0) {
      text = 'Time : ' + time.toString();
      redraw();
    }
    super.update(dt);
  }
}
