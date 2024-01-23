import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/theme/app_colors.dart';
import 'package:plinco/utils/layout_wrapper.dart';
import 'package:plinco/widgets/back_button.dart';
import 'package:plinco/widgets/common/stroke_text.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    super.key,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final AudioService audioService = AudioService();

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
            StrokeText(
              tr('update'),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Image.file(
                  ImagesService().getByFilename(assetsMap['update_decoration']!)!,
                  fit: BoxFit.fill,
                  height: 180,
                ),
                Positioned.fill(
                  top: -10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'update_desc'.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
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
                print('reboot app...');
              },
              child: Stack(
                children: [
                  Image.file(
                    ImagesService().getByFilename(assetsMap['reboot_btn']!)!,
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
                          tr('reboot'),
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
