part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

//Get HomeData
class HomeData extends HomeEvent {
  const HomeData();

  @override
  List<Object> get props => [];
}
