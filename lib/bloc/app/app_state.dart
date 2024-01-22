part of 'app_cubit.dart';

class AppState extends Equatable {
  final int score;
  final int balls;

  const AppState({
    this.score = 0,
    this.balls = 10,
  });

  @override
  List<Object?> get props => [score, balls];

  AppState copyWith({
    int? score,
    int? balls,
  }) {
    return AppState(
      score: score ?? this.score,
      balls: balls ?? this.balls,
    );
  }
}