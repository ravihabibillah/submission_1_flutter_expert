part of 'popular_bloc.dart';

@immutable
abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

// Movie Popular State
class PopularEmpty extends PopularState {}

class PopularLoading extends PopularState {}

class PopularError extends PopularState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviePopularHasData extends PopularState {
  final List<Movie> result;

  MoviePopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
