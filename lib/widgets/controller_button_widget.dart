import 'dart:developer';

import 'package:flutter/material.dart';

import '../global/global_game_references.dart';
import '../global/player_data.dart';

class ControllerButoonWidget extends StatefulWidget {
  final String path;
  final VoidCallback onPressed;
  const ControllerButoonWidget(
      {Key? key, required this.path, required this.onPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ControllerButoonWidget();
}

class _ControllerButoonWidget extends State<ControllerButoonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
            widget.onPressed();
          });
        },
        onTapUp: (_) {
          setState(() {
            // log("onTapUp");
            isPressed = false;
            GlobalGameReference.instance.gameRefernce.worldData.playerData
                .componentMotionState = ComponentMotionState.idle;
          });
        },
        child: Opacity(
          opacity: isPressed ? 0.5 : 0.8,
          child: SizedBox(
              height: screenSize.width / 17,
              width: screenSize.width / 17,
              child: Image.asset(widget.path)),
        ),
      ),
    );
  }
}
