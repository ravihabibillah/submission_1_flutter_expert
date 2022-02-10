part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

// Movie Detail State
class DetailEmpty extends MovieDetailState {}

class DetailLoading extends MovieDetailState {}

class DetailError extends MovieDetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends MovieDetailState {
  final MovieDetail result;

  DetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
