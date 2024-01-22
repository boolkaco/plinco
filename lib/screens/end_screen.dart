import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/models/level_model.dart';
import 'package:plinco/screens/game_screen.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/theme/app_colors.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/back_button.dart';
import 'package:plinco/widgets/common/stroke_text.dart';

class EndScreen extends StatefulWidget {
  final bool isWon;
  final LevelModel level;

  const EndScreen({
    super.key,
    required this.level,
    this.isWon = false,
  });

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  final AudioService audioService = AudioService();
  bool isMainSound = true;
  bool isButtonSound = true;

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
              ImagesService().getByFilename(assetsMap['logo']!)!,
              fit: BoxFit.cover,
            ),
            Stack(
              children: [
                Image.file(
                  ImagesService().getByFilename(assetsMap[
                      widget.isWon ? 'win_decoration' : 'lose_decoration']!)!,
                  fit: BoxFit.fill,
                  height: 200,
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.isWon ? 'won'.tr() : 'lose'.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      )
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                audioService.playSound('buttons_sound');
                BlocProvider.of<AppCubit>(context).resetGame();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => GameScreen(
                      level: widget.level,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.file(
                    ImagesService().getByFilename(assetsMap['again_btn']!)!,
                    fit: BoxFit.fill,
                    height: 100,
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StrokeText(
                          widget.isWon ? tr('try_again') : tr('play_again'),
                          color: AppColors.deepKoamaru,
                          strokeColor: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AppBackButton(
                  callback: () {
                    BlocProvider.of<AppCubit>(context).resetGame();
                  },
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