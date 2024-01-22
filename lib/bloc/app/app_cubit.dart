import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plinco/const/levels.dart';
import 'package:plinco/models/level_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(
    levels: Levels.list,
  ));

  void finishLevel(LevelModel level, int stars) {
    List<LevelModel> updatedLevels = state.levels.map((l) {
      if (l == level) {
        return l.copyWith(stars: stars);
      }
      return l;
    }).toList();

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
