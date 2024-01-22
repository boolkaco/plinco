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

  double _getCustomWidth() {
    if (type == AppButtonType.main) {
      return 240;
    } else if (type == AppButtonType.right) {
      return 210;
    } else {
      return 190;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            width: _getCustomWidth(),
            height: type == AppButtonType.main ? 120 : 80,
          ),
          SizedBox(
            width: _getCustomWidth(),
            height: type == AppButtonType.main ? 120 : 80,
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
