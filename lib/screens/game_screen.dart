import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/game/game_overlay.dart';
import 'package:plinco/widgets/game/plinco_game.dart';

class GameScreen extends StatelessWidget {
  final LevelModel level;

  const GameScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      opacity: 1,
      backgroundUrl: level.backgroundUrl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GameWidget<PlincoGame>(
              game: PlincoGame(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 35, left: 35),
              child: Column(
                children: [
                  GameOverlay(
                    level: level,
                  ),
                  // Возможно, вам понадобится другой виджет для интерфейса, если он должен быть поверх игры
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
