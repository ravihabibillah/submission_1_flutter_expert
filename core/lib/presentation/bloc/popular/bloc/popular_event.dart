part of 'popular_bloc.dart';

@immutable
abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviePopular extends PopularEvent {}

class FetchTvPopular extends PopularEvent {}
