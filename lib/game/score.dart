import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';

class Score extends TextBoxComponent {
  int _score = 0;

  /// 計分板
  Score(String text)
      : super(
          text: text,
          boxConfig: TextBoxConfig(
            timePerChar: 0.1,
          ),
        ) {}

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
    // text = _score.toString();
    super.update(dt);
  }
}
