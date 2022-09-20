import 'dart:developer';

import 'package:fast_noise/fast_noise.dart';
import 'package:minecraft/utils/game_methods.dart';

import '../resources/blocks.dart';
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
        chunkWidth, (index) => List.generate(chunkWidth, (index) => null));
  }

  List<List<Blocks?>> generationChunk() {
    List<List<Blocks?>> chunk = generateNullChunk();

    List<List<double>> rawNoise = noise2(
      chunkWidth,
      1,
      noiseType: NoiseType.Perlin,
      frequency: 0.05,
      seed: 98765,
    );

    List<int> yValues = getYValuesFromRawNoise(rawNoise);
    yValues.asMap().forEach((int index, int value) {
      chunk[value + GameMethods.instance.freeArea][index] = Blocks.grass;
    });
    // log(getYValuesFromRawNoise(rawNoise).toString());
    // log((getYValuesFromRawNoise(rawNoise).length).toString());
    // chunk.asMap().forEach((int indexOfRow, List<Blocks?> rowOfBlocks) {
    //   if (indexOfRow == 5) {
    //     rowOfBlocks.asMap().forEach((int index, Blocks? block) {
    //       chunk[5][index] = Blocks.grass;
    //     });
    //   }
    //   if (indexOfRow >= 6) {
    //     rowOfBlocks.asMap().forEach((int index, Blocks? block) {
    //       chunk[indexOfRow][index] = Blocks.dirt;
    //     });
    //   }
    // });
    return chunk;
  }

  List<List<Blocks?>> generatePrimerySoil(List<List<Blocks?>> chunk) {
    return chunk;
  }

  List<int> getYValuesFromRawNoise(List<List<double>> rawNoise) {
    List<int> yValues = [];
    rawNoise.asMap().forEach((int index, List<double> value) {
      yValues.add((value[0] * 10).toInt().abs());
    });
    return yValues;
  }
}
