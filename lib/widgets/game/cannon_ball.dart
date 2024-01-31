// ignore_for_file: library_prefixes, implementation_imports

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/game/moving_planet.dart';
import 'package:plinco/widgets/game/plinco_game.dart';
import 'package:plinco/services/logger.dart';

class CannonBall extends SpriteComponent with CollisionCallbacks, HasGameRef<PlincoGame> {
  static final Vector2 ballSize = Vector2(50, 50);
  final AppCubit appCubit;

  CannonBall(this.appCubit) : super(size: ballSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final ImageComposition.Image? ballImage = await ImagesService().getImageByFilename(assetsMap['ball']!);

    if (ballImage != null) {
      sprite = Sprite(ballImage);
      size = ballSize;
    } else {
      log.message('Cannot load the ball sprite image.');
    }
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * 600 * dt;

    if (position.y < 0) {
      removeFromParent();
      gameRef.cannon.reload();
      appCubit.useBall();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is MovingPlanet) {
      removeFromParent();
      gameRef.cannon.reload();
    }
  }
}
