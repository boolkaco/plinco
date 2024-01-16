import 'package:plinco/const/assets.dart';
import 'package:plinco/models/level_model.dart';

class Levels {
  static List<LevelModel> list = [
    LevelModel(
      backgroundUrl: assets['level_1_bg']!,
      previewUrl: assets['level_1_preview']!,
    ),
    LevelModel(
      backgroundUrl: assets['level_2_bg']!,
      previewUrl: assets['level_2_preview']!,
    ),
    LevelModel(
      backgroundUrl: assets['level_3_bg']!,
      previewUrl: assets['level_3_preview']!,
    ),
    LevelModel(
      backgroundUrl: assets['level_4_bg']!,
      previewUrl: assets['level_4_preview']!,
    ),
  ];
}