part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  AddWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  DeleteWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends WatchlistEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
