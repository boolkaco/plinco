import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinco/bloc/app/app_cubit.dart';
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/audio_service.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/theme/app_colors.dart';
import 'package:plinco/widgets/common/stroke_text.dart';

enum AppButtonType { main, right, left }

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final String label;
  final Function() onTap;
  final AudioService audioService = AudioService();

  AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = AppButtonType.main,
  });

  double _getCustomWidth(double screenWidth) {
    if (type == AppButtonType.main) {
      return screenWidth * 0.8;
    } else if (type == AppButtonType.right) {
      return screenWidth * 0.65;
    } else {
      return screenWidth * 0.65;
    }
  }

  double _getCustomHeight(double screenWidth) {
    if (type == AppButtonType.main) {
      return screenWidth * 0.14;
    } else if (type == AppButtonType.right) {
      return screenWidth * 0.09;
    } else {
      return screenWidth * 0.09;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if (context.read<AppCubit>().state.isButtonsSound) {
          audioService.playSound('buttons_sound');
        }
        onTap();
      },
      child: Stack(
        children: [
          Image.file(
            ImagesService().getByFilename(assetsMap['${type.name}_menu_btn']!)!,
            width: _getCustomWidth(screenWidth),
            height: _getCustomHeight(screenHeight),
          ),
          SizedBox(
            width: _getCustomWidth(screenWidth),
            height: _getCustomHeight(screenHeight),
            child: Center(
              child: StrokeText(
                label,
                fontWeight: type == AppButtonType.main
                    ? FontWeight.w900
                    : FontWeight.w800,
                size: type == AppButtonType.main
                    ? 30
                    : 20,
                color: AppColors.deepKoamaru,
                strokeColor: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
