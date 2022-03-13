import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';

import 'game/start_game.dart';

class StarsApp extends StatelessWidget {
  const StarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game',
      theme: ThemeData.dark(),
      home: Scaffold(body: GameWidget(game: StartGame())),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(const StarsApp());
}
