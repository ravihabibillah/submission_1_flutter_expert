part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

// Movie TopRated State
class TopRatedEmpty extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedError extends TopRatedState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedHasData extends TopRatedState {
  final List<Movie> result;

  MovieTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
