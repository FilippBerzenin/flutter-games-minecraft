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
    GameMethods.instance.addChunkToWorldChunks(
        ChunkGenerationMethods.instance.generationChunk(-1), false);
    GameMethods.instance.addChunkToWorldChunks(
        ChunkGenerationMethods.instance.generationChunk(0), true);
    GameMethods.instance.addChunkToWorldChunks(
        ChunkGenerationMethods.instance.generationChunk(1), true);
    renderChunk(-1);
    renderChunk(0);
    renderChunk(1);
  }

  void renderChunk(int chunkIndex) {
    Random().nextInt(5);
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);
    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) {
        if (block != null) {
          add(
            BlockComponent(
              block: block,
              blockIndex: Vector2(
                (chunkIndex * chunkWidth) + xIndex.toDouble(),
                yIndex.toDouble(),
              ),
              chunkIndex: chunkIndex,
            ),
          );
        }
      });
    });
  }

  double _playerPosition = 0;

  @override
  void update(double dt) {
    super.update(dt);
    // if (_playerPosition != GameMethods.instance.playerXIndexPosition) {
    //   _playerPosition = GameMethods.instance.playerXIndexPosition;
    //   print(worldData.chunksThatShouldBeRendered);
    // }
    worldData.chunksThatShouldBeRendered
        .asMap()
        .forEach((int index, int chunkIndex) {
      if (!worldData.currentlyRenderedChunks.contains(chunkIndex)) {
        if (chunkIndex >= 0) {
          if (worldData.rightWorldChunks[0].length ~/ chunkWidth <
              chunkIndex + 1) {
            GameMethods.instance.addChunkToWorldChunks(
                ChunkGenerationMethods.instance.generationChunk(chunkIndex),
                true);
          }
          renderChunk(chunkIndex);
          worldData.currentlyRenderedChunks.add(chunkIndex);
        } else {
          if (worldData.leftWorldChunks[0].length ~/ chunkWidth <
              chunkIndex.abs()) {
            GameMethods.instance.addChunkToWorldChunks(
                ChunkGenerationMethods.instance.generationChunk(chunkIndex),
                false);
          }
          renderChunk(chunkIndex);
          worldData.currentlyRenderedChunks.add(chunkIndex);
        }
      }
    });
  }
}
