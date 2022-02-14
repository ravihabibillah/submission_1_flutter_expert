part of 'movie_watchlist_bloc.dart';

@immutable
abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieWatchlist extends MovieWatchlistEvent {}
