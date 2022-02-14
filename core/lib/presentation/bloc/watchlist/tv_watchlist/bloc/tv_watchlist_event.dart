part of 'tv_watchlist_bloc.dart';

@immutable
abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchTvWatchlist extends TvWatchlistEvent {}
