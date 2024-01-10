import 'package:flutter/material.dart';
import 'package:plinco/widgets/common/oval_gradient_container.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  final String backgroundUrl;
  final double opacity;

  const BackgroundWrapper({
    Key? key,
    required this.child,
    this.backgroundUrl = 'assets/images/bg.png',
    this.opacity = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
          top: -size.height * 0.5,
          child: const OvalGradientContainer(),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: opacity,
            child: Image.asset(
              backgroundUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
