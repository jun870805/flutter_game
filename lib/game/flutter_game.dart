import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

import 'background.dart';
import 'ghost.dart';
import 'joystick.dart';
import 'lose.dart';
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
    'ghost.png',
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
  // 鬼
  late Ghost _ghost;
  // 計分板
  late ScoreDisplay _scoreDisplay;
  // 倒數計時器
  late TimeDisplay _timeDisplay;
  // 時間到
  late TimesUp _timesUp;
  // 時間到
  late Lose _lose;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await Flame.device.setOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    print("screenWidth:$screenWidth screenHeight:$screenHeight");

    // 載入圖片
    await images.loadAll(_assetsImages);

    // 背景
    final background = Background(this);

    // 開始遊戲(畫面)
    _startGame = StartGame(this);

    // 時間到(畫面)
    _timesUp = TimesUp(this);

    // 碰到鬼(畫面)
    _lose = Lose(this);

    // 刷新遊戲使用物件
    _initGame();

    addAll([background]);

    final style = TextStyle(color: BasicPalette.white.color);
    final regular = TextPaint(style: style);
    add(
      TextComponent(text: 'version:0.0.13', textRenderer: regular)
        ..anchor = Anchor.topCenter
        ..x = screenWidth / 2
        ..y = screenHeight - 32.0,
    );
  }

  void _initGame() {
    // 搖桿控制
    _joystick = Joystick(this);

    // 玩家
    _player = Player(this, _joystick);

    // 星星
    _star = Star(this);

    // 鬼
    _ghost = Ghost(this);

    // 計分板
    _scoreDisplay = ScoreDisplay(this);
    score = 0;

    // 倒數計時器
    _timeDisplay = TimeDisplay(this);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (parent == null) {
      super.updateTree(dt, callOwnUpdate: false);
    }
    // 遊戲流程設定物件
    if (changeStatus) {
      // 初始頁
      if (status == GameStatus.start) {
        removeAll([_scoreDisplay, _timeDisplay, _timesUp, _lose]);
        addAll([_startGame]);
      }
      // 開始遊戲
      if (status == GameStatus.play) {
        // 刷新遊戲使用物件
        _initGame();

        removeAll([_startGame]);
        addAll(
            [_joystick, _player, _star, _ghost, _scoreDisplay, _timeDisplay]);
      }
      // 時間到
      if (status == GameStatus.timesUp) {
        removeAll([_startGame, _joystick, _player, _star, _ghost]);
        addAll([_timesUp]);
      }
      // 碰到鬼
      if (status == GameStatus.lose) {
        _timeDisplay.time = -1;
        removeAll([_startGame, _joystick, _player, _star, _ghost]);
        addAll([_lose]);
      }
      changeStatus = false;
    }
  }
}
