import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plinco/const/levels.dart';
import 'package:plinco/models/level_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(levels: Levels.list));

  void saveLevels() async {
    var box = await Hive.openBox('box');
    List<Map<String, dynamic>> levelsJson =
        state.levels.map((level) => level.toJson()).toList();

    await box.put('levels', levelsJson);
    await box.close();
  }

  Future<void> loadLevels() async {
    var box = await Hive.openBox('box');
    var levelsJson = await box.get('levels');

    if (levelsJson != null) {
      List<LevelModel> loadedLevels = [];
      for (var levelMap in levelsJson) {
        Map<String, dynamic> castedLevelMap =
            Map<String, dynamic>.from(levelMap);
        loadedLevels.add(LevelModel.fromJson(castedLevelMap));
      }

      emit(state.copyWith(levels: loadedLevels));
    }
    await box.close();
  }

  void finishLevel(LevelModel level, int stars) {
    List<LevelModel> updatedLevels = state.levels.map((l) {
      if (l == level) {
        return l.copyWith(stars: stars);
      }
      return l;
    }).toList();
    saveLevels();
    emit(state.copyWith(levels: updatedLevels));
  }

  void addScore(int points) {
    emit(state.copyWith(
      levels: state.levels,
      score: state.score + points,
      balls: state.balls,
    ));
  }

  void useBall() {
    if (state.balls > 0) {
      emit(state.copyWith(
        levels: state.levels,
        score: state.score,
        balls: state.balls - 1,
      ));
    }
  }

  void resetGame() {
    emit(state.copyWith(
      levels: state.levels,
      balls: 10,
      score: 0,
      isButtonsSound: state.isButtonsSound,
      isBackgroundSound: state.isBackgroundSound,
    ));
  }

  void updateBackgroundSound() {
    emit(state.copyWith(
      levels: state.levels,
      isBackgroundSound: !state.isBackgroundSound,
    ));
  }

  void updateButtonsSound() {
    emit(state.copyWith(
      levels: state.levels,
      isButtonsSound: !state.isButtonsSound,
    ));
  }
}
