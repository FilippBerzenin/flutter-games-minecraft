import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../main_class.dart';
import 'controller_widget.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: MainGame()),
        const ControllerWidget(),
      ],
    );
  }
}
