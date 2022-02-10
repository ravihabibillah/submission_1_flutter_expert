part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieTopRated extends TopRatedEvent {
  FetchMovieTopRated();

  @override
  List<Object> get props => [];
}
