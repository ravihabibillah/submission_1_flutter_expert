part of 'recommendation_bloc.dart';

@immutable
abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecommendation extends RecommendationEvent {
  final int id;

  const FetchMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class FetchTvRecommendation extends RecommendationEvent {
  final int id;

  const FetchTvRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
