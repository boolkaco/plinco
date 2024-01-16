import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/game_screen.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/app_button.dart';

class LevelScreen extends StatelessWidget {
  final LevelModel level;

  const LevelScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(
              height: 114,
            ),
            Image.file(
              ImagesService().getByFilename(assets['logo']!)!,
              fit: BoxFit.cover,
            ),
            AppButton(
              label: "start".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => GameScreen(
                      level: level
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              label: "settings".tr(),
              type: AppButtonType.left,
              onTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              label: "privacy".tr(),
              type: AppButtonType.right,
              onTap: () {},
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.file(
                    ImagesService().getByFilename(assets['back_btn']!)!,
                    fit: BoxFit.fill,
                    width: 57,
                    height: 61,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 62,
            ),
          ],
        ),
      ),
    );
  }
}
