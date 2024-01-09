import 'package:flutter/material.dart';
import 'package:plinco/theme/app_colors.dart';
import 'package:plinco/widgets/common/stroke_text.dart';

enum AppButtonType { start, settings, privacy }

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final String label;

  const AppButton({
    super.key,
    required this.label,
    this.type = AppButtonType.start,
  });

  double _getCustomWidth() {
    if (type == AppButtonType.start) {
      return 240;
    } else if (type == AppButtonType.settings) {
      return 210;
    } else {
      return 190;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/${type.name}.png",
          width: _getCustomWidth(),
          height: type == AppButtonType.start ? 120 : 80,
        ),
        SizedBox(
          width: _getCustomWidth(),
          height: type == AppButtonType.start ? 120 : 80,
          child: Center(
            child: StrokeText(
              label,
              fontWeight: type == AppButtonType.start
                  ? FontWeight.w900
                  : FontWeight.w800,
              size: type == AppButtonType.start
                  ? 30
                  : 20,
              color: AppColors.deepKoamaru,
              strokeColor: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
