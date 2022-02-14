import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/tv_detail.dart';
import '../../../../domain/usecases/get_tv_detail.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetMovieDetail getMovieDetail;
  final GetTvDetail getTvDetail;

  DetailBloc({
    required this.getMovieDetail,
    required this.getTvDetail,
  }) : super(DetailEmpty()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        final id = event.id;

        emit(DetailLoading());
        final detailResult = await getMovieDetail.execute(id);

        detailResult.fold(
          (failure) => emit(DetailError(failure.message)),
          (data) => emit(MovieDetailHasData(data)),
        );
      },
    );

    on<FetchTvDetail>(
      (event, emit) async {
        final id = event.id;

        emit(DetailLoading());
        final detailResult = await getTvDetail.execute(id);

        detailResult.fold(
          (failure) => emit(DetailError(failure.message)),
          (data) => emit(TvDetailHasData(data)),
        );
      },
    );
  }
}
