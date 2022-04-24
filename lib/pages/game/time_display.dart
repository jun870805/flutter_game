import 'package:flame/components.dart';
import 'doodle_game.dart';
import 'dart:async' as async;

class TimeDisplay extends TextBoxComponent {
  late final DoodleGame _game;
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
    // 每一秒減一
    async.Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        time--;
        // 秒數歸0時，改變為時間到的狀態
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
    // 遊戲時間初始化
    time = 60;
    timeCountDown();
  }

  @override
  void update(double dt) {
    // 更新秒數
    if (text != time.toString() && time >= 0) {
      text = 'Time : ' + time.toString();
      redraw();
    }
    super.update(dt);
  }
}
