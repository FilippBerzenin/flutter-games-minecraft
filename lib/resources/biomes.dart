import 'package:minecraft/resources/structures.dart';
import 'package:minecraft/structures/trees.dart';

import 'blocks.dart';

enum Biomes {
  desert,
  birchForest,
}

class BiomeData {
  final Blocks primarySoil;
  final Blocks secondarySoil;
  final List<Structure> generationStructures;

  BiomeData(
      {required this.primarySoil,
      required this.secondarySoil,
      required this.generationStructures});

  factory BiomeData.getBiomeDataFor(Biomes biome) {
    switch (biome) {
      case Biomes.desert:
        return BiomeData(
            primarySoil: Blocks.sand,
            secondarySoil: Blocks.sand,
            generationStructures: []);
      case Biomes.birchForest:
        return BiomeData(
            primarySoil: Blocks.grass,
            secondarySoil: Blocks.dirt,
            generationStructures: [birchTree]);
    }
  }
}
