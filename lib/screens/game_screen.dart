import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/end_screen.dart';
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
              game: PlincoGame(
                level: level,
                appCubit: context.read<AppCubit>(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 35, left: 35),
              child: Column(
                children: [
                  BlocListener<AppCubit, AppState>(
                    listener: (context, state) {
                      if (state.score >= 700 || state.balls == 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndScreen(
                              level: level,
                              isWon: state.score >= 700,
                            ),
                          ),
                        );
                      }
                    },
                    child: GameOverlay(level: level), // Ваш GameOverlay виджет
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
