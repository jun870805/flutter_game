import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import './doodle_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    Flame.device.fullScreen();
    Flame.device.setLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: DoodleGame(),
    );
  }
}
