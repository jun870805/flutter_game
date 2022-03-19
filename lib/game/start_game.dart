import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'background.dart';
import 'joystick.dart';
import 'player.dart';
import 'score_display.dart';
import 'star.dart';
import 'time_display copy.dart';

class StartGame extends FlameGame with HasDraggables, HasCollidables {
  final double screenWidth = MediaQueryData.fromWindow(window).size.width;
  final double screenHeight = MediaQueryData.fromWindow(window).size.height;
  int score = 0;

  static const _assetsImages = [
    'player.png',
    'star.png',
    'joystick.png',
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();

    print("screenWidth:$screenWidth screenHeight:$screenHeight");

    // 載入圖片
    await images.loadAll(_assetsImages);

    // 背景
    final background = Background(this);

    // 搖桿控制
    final joystick = Joystick(this);

    // 玩家
    final player = Player(this, joystick);

    // 星星
    final star = Star(this);

    // 計分板
    final scoreDisplay = ScoreDisplay(this);

    // 倒數計時器
    final timeDisplay = TimeDisplay(this);

    addAll([joystick, background, player, star, scoreDisplay, timeDisplay]);
  }
}
