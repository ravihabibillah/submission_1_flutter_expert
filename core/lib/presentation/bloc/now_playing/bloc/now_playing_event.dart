part of 'now_playing_bloc.dart';

@immutable
abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieNowPlaying extends NowPlayingEvent {}

class FetchTvOnTheAir extends NowPlayingEvent {}
