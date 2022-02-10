part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {
  bool value = false;

  WatchlistInitial(this.value);

  @override
  List<Object> get props => [value];
}

// Movie Watchlist State
class WatchlistFailure extends WatchlistState {
  final String message;

  WatchlistFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSuccess extends WatchlistState {
  final String message;

  WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistState {
  final bool isAdded;

  WatchlistHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}
