import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'background.dart';
import 'joystick.dart';
import 'player.dart';
import 'score_display.dart';
import 'star.dart';
import 'start_game.dart';
import 'time_display.dart';
import 'times_up.dart';

enum GameStatus {
  start,
  play,
  lose,
  timesUp,
}

class FlutterGame extends FlameGame
    with HasDraggables, HasCollidables, HasTappables {
  final double screenWidth = MediaQueryData.fromWindow(window).size.width;
  final double screenHeight = MediaQueryData.fromWindow(window).size.height;
  int score = 0;

  static const _assetsImages = [
    'joystick.png',
    'lose.png',
    'player.png',
    'star.png',
    'start.png',
    'times_up.png',
  ];

  // 遊戲狀態管理
  GameStatus status = GameStatus.start;
  bool changeStatus = true;

  // 搖桿控制
  late Joystick _joystick;
  // 開始遊戲
  late StartGame _startGame;
  // 玩家
  late Player _player;
  // 星星
  late Star _star;
  // 計分板
  late ScoreDisplay _scoreDisplay;
  // 星星
  late TimeDisplay _timeDisplay;
  // 時間到
  late TimesUp _timesUp;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    print("screenWidth:$screenWidth screenHeight:$screenHeight");

    // 載入圖片
    await images.loadAll(_assetsImages);

    // 背景
    final background = Background(this);

    // 開始遊戲
    _startGame = StartGame(this);

    // 搖桿控制
    _joystick = Joystick(this);

    // 玩家
    _player = Player(this, _joystick);

    // 星星
    _star = Star(this);

    // 計分板
    _scoreDisplay = ScoreDisplay(this);

    // 倒數計時器
    _timeDisplay = TimeDisplay(this);

    // 時間到
    _timesUp = TimesUp(this);

    addAll([background]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (parent == null) {
      super.updateTree(dt, callOwnUpdate: false);
    }
    if (changeStatus) {
      if (status == GameStatus.start) {
        removeAll([_scoreDisplay, _timeDisplay, _timesUp]);
        addAll([_startGame]);
      }
      if (status == GameStatus.play) {
        // 刷新數據
        _scoreDisplay = ScoreDisplay(this);
        _timeDisplay = TimeDisplay(this);

        removeAll([_startGame]);
        addAll([_joystick, _player, _star, _scoreDisplay, _timeDisplay]);
      }
      if (status == GameStatus.timesUp) {
        removeAll([_startGame, _joystick, _player, _star]);
        addAll([_timesUp]);
      }
      changeStatus = false;
    }
  }
}
