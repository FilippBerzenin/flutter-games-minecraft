import '../resources/blocks.dart';
import '../resources/structures.dart';

Structure cactus = Structure(
  structure: [
    [Blocks.cactus],
    [Blocks.cactus]
  ],
  maxOccurences: 3,
  maxWidth: 1,
);

Structure deadBush = Structure(
  structure: [
    [Blocks.deadBush],
  ],
  maxOccurences: 3,
  maxWidth: 1,
);

Structure redFlower = Structure.getPlaintStructureForBlock(Blocks.redFlower);
Structure purpleFlower =
    Structure.getPlaintStructureForBlock(Blocks.purpleFlower);
Structure drippingWhiteFlower =
    Structure.getPlaintStructureForBlock(Blocks.drippingWhiteFlower);
Structure yellowFlower =
    Structure.getPlaintStructureForBlock(Blocks.yellowFlower);
Structure whiteFlower =
    Structure.getPlaintStructureForBlock(Blocks.whiteFlower);
