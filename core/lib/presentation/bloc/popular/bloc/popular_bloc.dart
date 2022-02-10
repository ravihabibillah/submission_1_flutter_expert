import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies getPopularMovies;

  PopularBloc({required this.getPopularMovies}) : super(PopularEmpty()) {
    on<PopularEvent>((event, emit) async {
      emit(PopularLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) => emit(PopularError(failure.message)),
        (data) => emit(MoviePopularHasData(data)),
      );
    });
  }
}
