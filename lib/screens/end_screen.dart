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
import 'package:plinco/widgets/app_logo.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.08,
            ),
            const AppLogo(),
            StrokeText(
              widget.isWon ? tr('congratulations') : tr('game_over'),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Image.file(
                  ImagesService().getByFilename(assetsMap[
                      widget.isWon ? 'win_decoration' : 'lose_decoration']!)!,
                  fit: BoxFit.fill,
                  height: 180,
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
                if (context.read<AppCubit>().state.isButtonsSound) {
                  audioService.playSound('buttons_sound');
                }
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
                    height: screenHeight * 0.12,
                  ),
                  Positioned(
                    top: screenHeight * 0.02,
                    bottom: screenHeight * 0.04,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StrokeText(
                          widget.isWon ? tr('try_again') : tr('play_again'),
                          color: AppColors.deepKoamaru,
                          strokeColor: AppColors.white,
                          size: screenHeight * 0.035,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppBackButton(
                callback: () {
                  BlocProvider.of<AppCubit>(context).resetGame();
                },
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
