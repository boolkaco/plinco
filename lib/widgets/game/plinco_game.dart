import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/game/cannon.dart';
import 'package:plinco/widgets/game/cannon_ball.dart';
import 'package:plinco/widgets/game/enemy.dart';

class PlincoGame extends FlameGame with PanDetector, HasCollisionDetection {
  final LevelModel level;
  late Cannon cannon;

  PlincoGame({required this.level});

  @override
  Future<void> onLoad() async {
    final ImageComposition.Image? bg2 =
        await ImagesService().getImageByFilename(level.backgroundUrl);
    if (bg2 != null) {
      final sprite = Sprite(bg2);
      final spriteComponent = SpriteComponent(sprite: sprite, size: size);
      add(spriteComponent);
    }

    cannon = Cannon()..position = size / 2;
    add(cannon);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    cannon.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    final cannonBall = CannonBall()
      ..position = cannon.position +
          Vector2(0, -cannon.size.y / 4 - CannonBall.ballSize.y / 4);
    add(cannonBall);
  }
}

class Bullet extends SpriteAnimationComponent
    with HasGameReference<PlincoGame> {
  Bullet({
    super.position,
  }) : super(
          size: Vector2(25, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'space/bullet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(8, 16),
      ),
    );

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -100;

    if (position.y < -height) {
      removeFromParent();
    }
  }
}

class Explosion extends SpriteAnimationComponent
    with HasGameReference<PlincoGame> {
  Explosion({
    super.position,
  }) : super(
          size: Vector2.all(150),
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'space/explosion.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
