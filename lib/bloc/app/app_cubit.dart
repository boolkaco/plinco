import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void addScore(int points) {
    emit(state.copyWith(
      score: state.score + points,
      balls: state.balls,
    ));
  }

  void useBall() {
    if (state.balls > 0) {
      emit(state.copyWith(
        score: state.score,
        balls: state.balls - 1,
      ));
    }
  }

  void resetGame() {
    emit(state.copyWith(
      balls: 10,
      score: 0,
      isButtonsSound: state.isButtonsSound,
      isBackgroundSound: state.isBackgroundSound,
    ));
  }

  void updateBackgroundSound() {
    emit(state.copyWith(
      isBackgroundSound: !state.isBackgroundSound,
    ));
  }

  void updateButtonsSound() {
    emit(state.copyWith(
      isButtonsSound: !state.isButtonsSound,
    ));
  }
}
