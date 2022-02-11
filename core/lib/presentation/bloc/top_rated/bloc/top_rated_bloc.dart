import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/tv.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  final GetTopRatedTv getTopRatedTv;

  TopRatedBloc({
    required this.getTopRatedMovies,
    required this.getTopRatedTv,
  }) : super(TopRatedEmpty()) {
    on<FetchMovieTopRated>((event, emit) async {
      emit(TopRatedLoading());

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedError(failure.message)),
        (data) => emit(MovieTopRatedHasData(data)),
      );
    });

    on<FetchTvTopRated>((event, emit) async {
      emit(TopRatedLoading());

      final result = await getTopRatedTv.execute();

      result.fold(
        (failure) => emit(TopRatedError(failure.message)),
        (data) => emit(TvTopRatedHasData(data)),
      );
    });
  }
}
