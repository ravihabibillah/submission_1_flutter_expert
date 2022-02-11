import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_on_the_air_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/tv.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetOnTheAirTv getOnTheAirTv;

  NowPlayingBloc({
    required this.getNowPlayingMovies,
    required this.getOnTheAirTv,
  }) : super(NowPlayingEmpty()) {
    on<FetchMovieNowPlaying>((event, emit) async {
      emit(NowPlayingLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(NowPlayingError(failure.message)),
        (data) => emit(MovieNowPlayingHasData(data)),
      );
    });

    on<FetchTvOnTheAir>((event, emit) async {
      emit(NowPlayingLoading());

      final result = await getOnTheAirTv.execute();

      result.fold(
        (failure) => emit(NowPlayingError(failure.message)),
        (data) => emit(TvOnTheAirHasData(data)),
      );
    });
  }
}
