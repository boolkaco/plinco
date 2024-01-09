import 'package:flutter/material.dart';
import 'package:plinco/theme/app_colors.dart';

class StrokeText extends StatelessWidget {
  final String text;

  const StrokeText(this.text, {super.key,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = AppColors.aqua,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.white,
          ),
        )
      ],
    );
  }
}
