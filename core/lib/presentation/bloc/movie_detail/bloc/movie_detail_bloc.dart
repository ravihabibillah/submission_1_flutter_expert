import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(
    this._getMovieDetail,
  ) : super(DetailEmpty()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        final id = event.id;

        emit(DetailLoading());
        final detailResult = await _getMovieDetail.execute(id);

        detailResult.fold(
          (failure) => emit(DetailError(failure.message)),
          (data) => emit(DetailHasData(data)),
        );
      },
    );
  }
}
