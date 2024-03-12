part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

///HOME INITITAL STATE
class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

//HOME SATTES
class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  final HomeModal homeModal;

  const HomeSuccess({required this.homeModal});

  @override
  List<Object?> get props => [homeModal];
}

class HomeError extends HomeState {
  final int statusCode;
  final String errorMessage;

  const HomeError({required this.statusCode, required this.errorMessage});

  @override
  List<Object?> get props => [statusCode, errorMessage];
}
