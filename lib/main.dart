import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(const GamePage());
}
