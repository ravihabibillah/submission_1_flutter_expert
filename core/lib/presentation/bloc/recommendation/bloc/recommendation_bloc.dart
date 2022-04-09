import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/tv.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  final GetTvRecommendations getTvRecommendations;

  RecommendationBloc({
    required this.getMovieRecommendations,
    required this.getTvRecommendations,
  }) : super(RecommendationEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      final id = event.id;

      emit(RecommendationLoading());

      final recommendationResult = await getMovieRecommendations.execute(id);

      recommendationResult.fold(
        (failure) => emit(RecommendationError(failure.message)),
        (data) => emit(MovieRecommendationHasData(data)),
      );
    });

    on<FetchTvRecommendation>((event, emit) async {
      final id = event.id;

      emit(RecommendationLoading());

      final recommendationResult = await getTvRecommendations.execute(id);

      recommendationResult.fold(
        (failure) => emit(RecommendationError(failure.message)),
        (data) => emit(TvRecommendationHasData(data)),
      );
    });
  }
}
