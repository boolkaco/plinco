import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/level_screen.dart';
import 'package:plinco/screens/menu_screen.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/theme/app_colors.dart';

class GameOverlay extends StatelessWidget {
  final LevelModel level;

  GameOverlay({super.key, required this.level});

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            audioService.playSound('buttons_sound');
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
          child: Image.file(
            ImagesService().getByFilename(assetsMap['home_btn']!)!,
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
                    Image.file(
                      ImagesService().getByFilename(assetsMap['coin_icon']!)!,
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
                    Image.file(
                      ImagesService().getByFilename(assetsMap['ball_icon']!)!,
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
            audioService.playSound('buttons_sound');
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
          child: Image.file(
            ImagesService().getByFilename(assetsMap['settings_btn']!)!,
            width: 59,
            height: 62,
          ),
        ),
      ],
    );
  }
}
