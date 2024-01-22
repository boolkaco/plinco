part of 'app_cubit.dart';

class AppState extends Equatable {
  final int score;
  final int balls;
  final bool isBackgroundSound;
  final bool isButtonsSound;

  const AppState({
    this.score = 0,
    this.balls = 10,
    this.isBackgroundSound = true,
    this.isButtonsSound = true,
  });

  @override
  List<Object?> get props => [score, balls, isBackgroundSound, isButtonsSound];

  AppState copyWith({
    int? score,
    int? balls,
    bool? isBackgroundSound,
    bool? isButtonsSound,
  }) {
    return AppState(
      score: score ?? this.score,
      balls: balls ?? this.balls,
      isBackgroundSound: isBackgroundSound ?? this.isBackgroundSound,
      isButtonsSound: isButtonsSound ?? this.isButtonsSound,
    );
  }
}