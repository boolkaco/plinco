import 'package:flutter/material.dart';
import 'package:plinco/widgets/menu/score_stars.dart';

class LevelSelectMenu extends StatelessWidget {
  final String backgroundUrl;
  final bool isRightPlay;
  final int score;
  final Function() onTap;

  const LevelSelectMenu({
    super.key,
    required this.backgroundUrl,
    required this.onTap,
    this.isRightPlay = true,
    this.score = 0,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    backgroundUrl,
                    width: 303,
                    height: 223,
                  ),
                  Positioned(
                    bottom: 0,
                    right: isRightPlay ? 20 : null,
                    left: isRightPlay ? null : 20,
                    child: Image.asset(
                      'assets/images/play_btn.png',
                      width: 57,
                      height: 62,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ScoreStars(
              score: score,
            ),
          ),
        ],
      ),
    );
  }
}
