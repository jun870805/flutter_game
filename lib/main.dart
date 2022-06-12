import 'package:flutter/material.dart';

import './includes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initConfig('stable');

  runApp(const HomePage());
}
