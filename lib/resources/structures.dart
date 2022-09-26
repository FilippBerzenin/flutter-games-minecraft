import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:minecraft/global/global_game_references.dart';
import 'package:minecraft/utils/game_methods.dart';

import '../resources/blocks.dart';

class Structure {
  final List<List<Blocks?>> structure;
  final int maxOccurences;
  final int maxWidth;

  Structure({
    required this.structure,
    required this.maxOccurences,
    required this.maxWidth,
  });
}
