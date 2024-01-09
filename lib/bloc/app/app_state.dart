part of 'app_cubit.dart';

class AppState extends Equatable {
  final String searchTarget;

  const AppState({
    this.searchTarget = '',
  });

  @override
  List<Object?> get props => [
    searchTarget,
  ];

  AppState copyWith({
    String? searchTarget = '',
  }) {
    return AppState(
      searchTarget: searchTarget ?? this.searchTarget,
    );
  }
}