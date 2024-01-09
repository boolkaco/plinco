import 'package:flutter/material.dart';
import 'package:plinco/utils/layout_wrapper.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Column(
        children: [
          const SizedBox(
            height: 114,
          ),
          Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
