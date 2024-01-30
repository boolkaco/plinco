// ignore_for_file: library_prefixes, implementation_imports

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/game/cannon.dart';
import 'package:plinco/widgets/game/moving_planet.dart';

class PlincoGame extends FlameGame with PanDetector, HasCollisionDetection {
  static final Random _random = Random();
  final LevelModel level;
  late Cannon cannon;
  late int maxPlanets;
  final List<MovingPlanet> planets = [];
  final Set<int> availablePlanets = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  final AppCubit appCubit;
  double timeElapsed = 0.0;

  PlincoGame({
    required this.level,
    required this.appCubit,
  }) {
    maxPlanets = level.maxPlanet;
  }

  @override
  Future<void> onLoad() async {
    final ImageComposition.Image? bg2 = await ImagesService().getImageByFilename(level.backgroundUrl);
    if (bg2 != null) {
      final sprite = Sprite(bg2);
      final spriteComponent = SpriteComponent(sprite: sprite, size: size);
      add(spriteComponent);
    }

    cannon = Cannon(appCubit)..position = size / 2;
    add(cannon);

    spawnPlanet();
    startTimer();
  }

  void startTimer() {
    timeElapsed = 0.0;
  }

  void updateTimer(double dt) {
    timeElapsed += dt;
  }

  void finishLevel(bool isWon) {
    int stars;
    if (timeElapsed <= 10) {
      stars = 3;
    } else if (timeElapsed <= 20) {
      stars = 2;
    } else {
      stars = 0;
    }
    if (!isWon) {
      stars = 0;
    }
    appCubit.finishLevel(level, stars);
  }

  void spawnPlanet() {
    if (planets.length < maxPlanets && availablePlanets.isNotEmpty) {
      final index = availablePlanets.elementAt(_random.nextInt(availablePlanets.length));
      availablePlanets.remove(index);
      final movingPlanet = MovingPlanet(
        index,
        appCubit,
        maxSpeed: level.maxSpeedPlanet,
        minSpeed: level.minSpeedPlanet,
      );
      add(movingPlanet);
      planets.add(movingPlanet);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateTimer(dt);
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
