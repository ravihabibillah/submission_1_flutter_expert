import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:rxdart/transformers.dart';

import '../domain/usecases/search_tv.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  final SearchTv searchTv;

  SearchBloc({
    required this.searchMovies,
    required this.searchTv,
  }) : super(SearchEmpty()) {
    on<OnMovieQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchMovieHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnTvQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await searchTv.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
