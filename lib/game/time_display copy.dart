import 'package:flame/components.dart';
import './start_game.dart';
import 'dart:async' as time;

class TimeDisplay extends TextBoxComponent {
  late StartGame game;
  late int _time;

  /// 計分板
  TimeDisplay(_game)
      : super(
          boxConfig: TextBoxConfig(
            timePerChar: 0.1,
            maxWidth: 120,
          ),
          position: Vector2(_game.screenWidth - 120, 10),
        ) {
    game = _game;
  }

  void _timeCountDown() {
    time.Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _time--;
        if (_time <= 0) {
          timer.cancel();
        }
      },
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _time = 60;
    _timeCountDown();
    // await redraw();
  }

  @override
  void update(double dt) {
    if (text != _time.toString() && _time >= 0) {
      text = 'Time : ' + _time.toString();
      redraw();
    }
    super.update(dt);
  }
}
