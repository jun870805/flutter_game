import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import './doodle_game.dart';
import '../../includes.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: GameWidget(
          game: DoodleGame(),
        ),
      ),
    );
  }
}
