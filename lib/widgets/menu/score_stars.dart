import 'package:flutter/material.dart';
import 'package:plinco/const/assets.dart';

class ScoreStars extends StatelessWidget {
  final int score;

  const ScoreStars({super.key, this.score = 0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 80,
          width: 133,
          child: Image.network(assets['stars']!),
        ),
        if (score >= 1)
          Positioned(
            bottom: 6,
            left: 6,
            child: Transform.rotate(
              angle: 1.1,
              child: SizedBox(
                height: 40,
                width: 40,
                child: Image.network(assets['filled_star']!),
              ),
            ),
          ),
        if (score >= 2)
          Positioned.fill(
            top: 4,
            bottom: 14,
            child: Image.network(assets['filled_star']!),
          ),
        if (score >= 3)
          Positioned(
            right: 4,
            bottom: 6,
            child: Transform.rotate(
              angle: 0.4,
              child: SizedBox(
                height: 40,
                width: 40,
                child: Image.network(assets['filled_star']!),
              ),
            ),
          ),
      ],
    );
  }
}
