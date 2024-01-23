import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/menu/score_stars.dart';

class LevelSelectMenu extends StatelessWidget {
  final String backgroundUrl;
  final bool isRightPlay;
  final bool isLock;
  final int score;
  final Function() onTap;

  const LevelSelectMenu({
    super.key,
    required this.backgroundUrl,
    required this.onTap,
    required this.isLock,
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
                  Image.file(
                    ImagesService().getByFilename(backgroundUrl)!,
                    width: 303,
                    height: 223,
                  ),
                  if (!isLock)
                    Positioned(
                      bottom: 0,
                      right: isRightPlay ? 20 : null,
                      left: isRightPlay ? null : 20,
                      child: Image.file(
                        ImagesService().getByFilename(assetsMap['play_btn']!)!,
                        width: 57,
                        height: 62,
                      ),
                    ),
                  if (isLock)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.file(
                          ImagesService().getByFilename(assetsMap['lock']!)!,
                          width: 80,
                          height: 80,
                        ),
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
