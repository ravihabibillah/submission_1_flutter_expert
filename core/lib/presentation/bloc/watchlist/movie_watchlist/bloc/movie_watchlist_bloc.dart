import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../domain/entities/movie.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  MovieWatchlistBloc(this._getWatchlistMovies) : super(MovieWatchlistEmpty()) {
    on<FetchMovieWatchlist>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(MovieWatchlistError(failure.message)),
        (data) => emit(MovieWatchlistHasData(data)),
      );
    });
  }
}
