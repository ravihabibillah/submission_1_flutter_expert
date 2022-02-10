import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/movie.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedBloc({required this.getTopRatedMovies}) : super(TopRatedEmpty()) {
    on<FetchMovieTopRated>((event, emit) async {
      emit(TopRatedLoading());

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedError(failure.message)),
        (data) => emit(MovieTopRatedHasData(data)),
      );
    });
  }
}
