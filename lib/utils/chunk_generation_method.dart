import 'dart:developer';
import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:minecraft/global/global_game_references.dart';
import 'package:minecraft/resources/biomes.dart';
import 'package:minecraft/resources/structures.dart';
import 'package:minecraft/utils/game_methods.dart';

import '../resources/blocks.dart';
import '../structures/trees.dart';
import 'constants.dart';

class ChunkGenerationMethods {
  static ChunkGenerationMethods get instance {
    return ChunkGenerationMethods();
  }

  List<Null> getNullRow() {
    return List.generate(chunkWidth, (index) => null);
  }

  List<List<Blocks?>> generateNullChunk() {
    return List.generate(
      chunkHeight,
      (index) => List.generate(chunkWidth, (index) => null),
    );
  }

  List<List<Blocks?>> generationChunk(int chunkIndex) {
    Biomes biome = Random().nextBool() ? Biomes.birchForest : Biomes.desert;
    List<List<Blocks?>> chunk = generateNullChunk();

    List<List<double>> rawNoise = noise2(
      chunkIndex >= 0
          ? chunkWidth * (chunkIndex + 1)
          : chunkWidth * (chunkIndex.abs()),
      1,
      noiseType: NoiseType.Perlin,
      frequency: 0.05,
      seed: chunkIndex >= 0
          ? GlobalGameReference.instance.gameRefernce.worldData.seed
          : GlobalGameReference.instance.gameRefernce.worldData.seed + 10,
    );

    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    yValues.removeRange(
        0,
        chunkIndex >= 0
            ? chunkWidth * chunkIndex
            : chunkWidth * (chunkIndex.abs() - 1));

    chunk = generatePrimarySoil(chunk, yValues, biome);
    chunk = generateSecondarySoil(chunk, yValues, biome);
    chunk = generateStone(chunk);
    chunk = addStructureToChunk(chunk, yValues, biome);
    return chunk;
  }

  List<List<Blocks?>> generatePrimarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    yValues.asMap().forEach((int index, int value) {
      chunk[value][index] = BiomeData.getBiomeDataFor(biome).primarySoil;
    });
    return chunk;
  }

  List<List<Blocks?>> generateSecondarySoil(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    yValues.asMap().forEach((int index, int value) {
      for (int i = value + 1;
          i <= GameMethods.instance.maxSecondarySoilExtend;
          i++) {
        chunk[i][index] = BiomeData.getBiomeDataFor(biome).secondarySoil;
      }
    });
    return chunk;
  }

  List<List<Blocks?>> addStructureToChunk(
      List<List<Blocks?>> chunk, List<int> yValues, Biomes biome) {
    BiomeData.getBiomeDataFor(biome)
        .generationStructures
        .asMap()
        .forEach((key, Structure currentStructure) {
      for (int occurrence = 0;
          occurrence < currentStructure.maxOccurences;
          occurrence++) {
        List<List<Blocks?>> structureList =
            List.from(currentStructure.structure.reversed);

        int xPositionOfStructure =
            Random().nextInt(chunkWidth - currentStructure.maxWidth);
        int yPositionOfStructure =
            (yValues[xPositionOfStructure + (currentStructure.maxWidth ~/ 2)]) -
                1;

        birchTree.structure.reversed;

        for (int indexOfRow = 0;
            indexOfRow < currentStructure.structure.length;
            indexOfRow++) {
          List<Blocks?> rowOfBlocksInStructure = structureList[indexOfRow];
          rowOfBlocksInStructure
              .asMap()
              .forEach((int index, Blocks? blockInStructure) {
            if (chunk[yPositionOfStructure - indexOfRow]
                    [xPositionOfStructure + index] ==
                null) {
              chunk[yPositionOfStructure - indexOfRow]
                  [xPositionOfStructure + index] = blockInStructure;
            }
          });
        }
      }
    });
    return chunk;
  }

  List<List<Blocks?>> generateStone(List<List<Blocks?>> chunk) {
    for (int index = 0; index < chunkWidth; index++) {
      for (int i = GameMethods.instance.maxSecondarySoilExtend + 1;
          i < chunk.length;
          i++) {
        chunk[i][index] = Blocks.stone;
      }
    }
    int x1 = Random().nextInt(chunkWidth ~/ 2);
    int x2 = x1 + Random().nextInt(chunkWidth ~/ 2);
    chunk[GameMethods.instance.maxSecondarySoilExtend]
        .fillRange(x1, x2, Blocks.stone);
    return chunk;
  }

  List<int> getYValuesFromRawNoise(List<List<double>> rawNoise) {
    List<int> yValues = [];
    rawNoise.asMap().forEach((int index, List<double> value) {
      yValues
          .add((value[0] * 10).toInt().abs() + GameMethods.instance.freeArea);
    });
    return yValues;
  }
}
