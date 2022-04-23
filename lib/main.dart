import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';

import './includes.dart';

class StarsApp extends StatelessWidget {
  const StarsApp({Key? key}) : super(key: key);

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(const StarsApp());
}
