import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/tv.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies getPopularMovies;
  final GetPopularTv getPopularTv;

  PopularBloc({
    required this.getPopularMovies,
    required this.getPopularTv,
  }) : super(PopularEmpty()) {
    on<FetchMoviePopular>((event, emit) async {
      emit(PopularLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) => emit(PopularError(failure.message)),
        (data) => emit(MoviePopularHasData(data)),
      );
    });

    on<FetchTvPopular>((event, emit) async {
      emit(PopularLoading());

      final result = await getPopularTv.execute();

      result.fold(
        (failure) => emit(PopularError(failure.message)),
        (data) => emit(TvPopularHasData(data)),
      );
    });
  }
}
