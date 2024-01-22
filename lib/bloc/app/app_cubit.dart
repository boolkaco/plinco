import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void addScore(int points) {
    emit(AppState(score: state.score + points, balls: state.balls));
  }

  void useBall() {
    if (state.balls > 0) {
      emit(AppState(score: state.score, balls: state.balls - 1));
    }
  }

  void resetGame() {
    emit(const AppState());
  }
}