part of 'detail_bloc.dart';

@immutable
abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

// Movie Detail State
class DetailEmpty extends DetailState {}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends DetailState {
  final MovieDetail result;

  const MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvDetailHasData extends DetailState {
  final TvDetail result;

  const TvDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
