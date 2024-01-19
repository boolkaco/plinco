import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:plinco/models/level_model.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/game/cannon.dart';
import 'package:plinco/widgets/game/moving_planet.dart';

class PlincoGame extends FlameGame with PanDetector, HasCollisionDetection {
  static final Random _random = Random();
  final LevelModel level;
  late Cannon cannon;
  final int maxPlanets = 4;
  final List<MovingPlanet> planets = [];
  final Set<int> availablePlanets = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

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

    spawnPlanet();
  }

  void spawnPlanet() {
    if (planets.length < maxPlanets && availablePlanets.isNotEmpty) {
      final index = availablePlanets.elementAt(_random.nextInt(availablePlanets.length));
      availablePlanets.remove(index);
      final movingPlanet = MovingPlanet(index);
      add(movingPlanet);
      planets.add(movingPlanet);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    planets.removeWhere((planet) => planet.isRemoved);
    if (planets.length < maxPlanets) {
      spawnPlanet();
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    cannon.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    cannon.shoot();
  }
}
