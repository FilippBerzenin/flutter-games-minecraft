import 'dart:math';

import "package:flame/game.dart";
import 'package:get/get.dart';
import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/components/player_component.dart';
import 'package:minecraft/global/world_data.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/utils/chunk_generation_method.dart';
import 'package:minecraft/utils/constants.dart';
import 'package:minecraft/utils/game_methods.dart';

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
    camera.followComponent(playerComponent);
    add(playerComponent);
    GameMethods.instance.addChunkToRightWorldChunks(
        ChunkGenerationMethods.instance.generationChunk(0));
    GameMethods.instance.addChunkToRightWorldChunks(
        ChunkGenerationMethods.instance.generationChunk(1));
    GameMethods.instance.addChunkToRightWorldChunks(
        ChunkGenerationMethods.instance.generationChunk(2));
    renderChunk(0);
    renderChunk(1);
    renderChunk(2);
  }

  void renderChunk(int chunkIndex) {
    Random().nextInt(5);
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);
    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) {
        if (block != null) {
          add(BlockComponent(
              block: block,
              blockIndex: Vector2((chunkIndex * chunkWidth) + xIndex.toDouble(),
                  yIndex.toDouble())));
        }
      });
    });
  }
}
