import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'layout/game_layout.dart';
import 'main_class.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      home: GameLayout(),
    ),
  );
}
