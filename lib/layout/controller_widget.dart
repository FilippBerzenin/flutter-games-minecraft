import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/controller_button_widget.dart';

class ControllerWidget extends StatelessWidget {
  const ControllerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            ControllerButoonWidget(
              path: 'assets/controller/left_button.png',
              onPressed: () {
                log("Left Buttom pressed");
              },
            ),
            ControllerButoonWidget(
              path: 'assets/controller/center_button.png',
              onPressed: () {
                log("Center Buttom pressed");
              },
            ),
            ControllerButoonWidget(
              path: 'assets/controller/right_button.png',
              onPressed: () {
                log("Right Buttom pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
