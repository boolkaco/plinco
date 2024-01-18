import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:plinco/widgets/game/plinco_game.dart';

class MovingPlanet extends SpriteComponent with HasGameRef<PlincoGame>, CollisionCallbacks {
  static final Random _random = Random();
  late double speed;
  late bool movingLeft;
  late double rotationSpeed;
  late int imageIndex;

  MovingPlanet(this.imageIndex) : super(
    anchor: Anchor.center,
    size: Vector2.all(100.0),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final imageIndex = Random().nextInt(10) + 1;
    sprite = await gameRef.loadSprite('planet_$imageIndex.png');

    speed = _random.nextDouble() * (300 - 100) + 100;
    movingLeft = _random.nextBool();
    rotationSpeed = _random.nextDouble() * 2 - 1;

    final verticalPosition = _random.nextDouble() * (500 - 150) + 150;
    position = Vector2(
        movingLeft ? gameRef.size.x : 0.0,
        verticalPosition
    );
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
}
