import 'package:flutter/material.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/level_screen.dart';
import 'package:plinco/screens/menu_screen.dart';
import 'package:plinco/theme/app_colors.dart';

class GameOverlay extends StatelessWidget {
  final LevelModel level;

  const GameOverlay({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const MenuScreen(
                  isLoaded: true,
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          child: Image.asset(
            "assets/images/home_btn.png",
            width: 59,
            height: 62,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 2,
              right: 24,
              left: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/coin_icon.png",
                      width: 28,
                      height: 30,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "100",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.white,
                                height: 3.2,
                              ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/ball_icon.png",
                      width: 28,
                      height: 30,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "20",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.white,
                                height: 3.2,
                              ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    LevelScreen(level: level),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          child: Image.asset(
            "assets/images/settings_btn.png",
            width: 59,
            height: 62,
          ),
        ),
      ],
    );
  }
}
