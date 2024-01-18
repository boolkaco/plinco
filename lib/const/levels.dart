import 'package:plinco/const/assets.dart';
import 'package:plinco/models/level_model.dart';

class Levels {
  static List<LevelModel> list = [
    LevelModel(
      backgroundUrl: assetsMap['level_1_bg']!,
      previewUrl: assetsMap['level_1_preview']!,
    ),
    LevelModel(
      backgroundUrl: assetsMap['level_2_bg']!,
      previewUrl: assetsMap['level_2_preview']!,
    ),
    LevelModel(
      backgroundUrl: assetsMap['level_3_bg']!,
      previewUrl: assetsMap['level_3_preview']!,
    ),
    LevelModel(
      backgroundUrl: assetsMap['level_4_bg']!,
      previewUrl: assetsMap['level_4_preview']!,
    ),
  ];
}