import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:minecraft/global/global_game_references.dart';

import '../global/player_data.dart';

class PlayerComponent extends SpriteAnimationComponent {
  final int speed = 5;
  bool isFacingRight = true;
  final Vector2 playerDimensions = Vector2(60, 60);
  final double stepTime = 0.3;

  late SpriteSheet playerWalkingSpriteSheet;
  late SpriteSheet playerIdleSpriteSheet;

  late SpriteAnimation walkingAnimation =
      playerWalkingSpriteSheet.createAnimation(row: 0, stepTime: stepTime);

  late SpriteAnimation idleAnimation =
      playerIdleSpriteSheet.createAnimation(row: 0, stepTime: stepTime);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    playerWalkingSpriteSheet = SpriteSheet(
        image: await Flame.images
            .load("sprite_sheets/player/player_walking_sprite_sheet.png"),
        srcSize: playerDimensions);
    playerIdleSpriteSheet = SpriteSheet(
        image: await Flame.images
            .load("sprite_sheets/player/player_idle_sprite_sheet.png"),
        srcSize: playerDimensions);
    size = Vector2(100, 100);
    position = Vector2(100, 500);
    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic();
  }

  void movementLogic() {
    //Moving Left
    if (GlobalGameReference
            .instance.gameRefernce.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingLeft) {
      position.x -= speed;
      if (isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = false;
      }
      animation = walkingAnimation;
    }
    // Moving Right
    if (GlobalGameReference
            .instance.gameRefernce.worldData.playerData.componentMotionState ==
        ComponentMotionState.walkingRight) {
      position.x += speed;
      if (!isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = true;
      }
    }
    if (GlobalGameReference
            .instance.gameRefernce.worldData.playerData.componentMotionState ==
        ComponentMotionState.idle) {
      animation = idleAnimation;
    }
  }
}
