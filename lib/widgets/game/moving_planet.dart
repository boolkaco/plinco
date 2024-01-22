import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/game/cannon_ball.dart';
import 'package:plinco/widgets/game/explosion.dart';
import 'package:plinco/widgets/game/plinco_game.dart';

class MovingPlanet extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PlincoGame> {
  static final Random _random = Random();
  late double speed;
  late bool movingLeft;
  late double rotationSpeed;
  late int imageIndex;
  final int maxSpeed;
  final int minSpeed;
  final AppCubit appCubit;

  MovingPlanet(
    this.imageIndex,
    this.appCubit, {
    required this.maxSpeed,
    required this.minSpeed,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(100.0),
        );

  final AudioService audioService = AudioService();

  bool _isExploding = false;
  final double hitboxRatio = 0.6;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final imageIndex = Random().nextInt(10) + 1;
    Image? planetImage = await ImagesService().getImageByFilename(
      assetsMap['planet_$imageIndex']!,
    );
    sprite = Sprite(planetImage!);

    speed = _random.nextDouble() * (maxSpeed - minSpeed) + minSpeed;
    movingLeft = _random.nextBool();
    rotationSpeed = _random.nextDouble() * 2 - 1;

    final verticalPosition = _random.nextDouble() * (500 - 150) + 150;
    position = Vector2(movingLeft ? gameRef.size.x : 0.0, verticalPosition);

    Vector2 hitboxSize = size * hitboxRatio;
    Vector2 hitboxPosition = (size - hitboxSize) / 2;
    add(RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += (movingLeft ? -1 : 1) * speed * dt;
    angle += rotationSpeed * dt;

    bool isOffScreen = movingLeft
        ? position.x < -size.x
        : position.x > gameRef.size.x + size.x;

    if (isOffScreen) {
      removeFromParent();
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    gameRef.availablePlanets.add(imageIndex);
    gameRef.spawnPlanet();
  }

  @override
  Future<void> onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);
    if (other is CannonBall && !_isExploding) {
      _isExploding = true;
      Image? explosionImage = await ImagesService().getImageByFilename(
        assetsMap['boom']!,
      );
      final explosion = Explosion(
        image: explosionImage!,
        position: position.clone() + Vector2(-50, -50),
      );
      audioService.playSound('boom_sound');
      gameRef.add(explosion);
      removeFromParent();
      other.removeFromParent();
      gameRef.cannon.reload();
      appCubit.addScore(100);
      appCubit.useBall();
    }
  }
}
