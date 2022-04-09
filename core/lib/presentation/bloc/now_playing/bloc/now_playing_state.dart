part of 'now_playing_bloc.dart';

@immutable
abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

// Movie NowPlaying State
class NowPlayingEmpty extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingError extends NowPlayingState {
  final String message;

  const NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieNowPlayingHasData extends NowPlayingState {
  final List<Movie> result;

  const MovieNowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvOnTheAirHasData extends NowPlayingState {
  final List<Tv> result;

  const TvOnTheAirHasData(this.result);

  @override
  List<Object> get props => [result];
}
