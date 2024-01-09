import 'package:flutter/material.dart';
import 'package:plinco/widgets/common/oval_gradient_container.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  const BackgroundWrapper({
    Key? key,
    required this.child,
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
            opacity: 0.5,
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
