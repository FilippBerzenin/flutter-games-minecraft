import "package:flame/game.dart";
import 'package:get/get.dart';
import 'package:minecraft/components/player_component.dart';
import 'package:minecraft/global/world_data.dart';

import 'global/global_game_references.dart';

class MainGame extends FlameGame {
  final WorldData worldData;

  MainGame({required this.worldData}) {
    globalGameRefernce.gameRefernce = this;
  }

  GlobalGameReference globalGameRefernce = Get.put(GlobalGameReference());
  PlayerComponent playerComponent = PlayerComponent();
  @override
  Future<void>? onLoad() async {
    super.onLoad();
    add(PlayerComponent());
  }
}
