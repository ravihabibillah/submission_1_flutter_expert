part of 'recommendation_bloc.dart';

@immutable
abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

// Movie Recommendation State
class RecommendationEmpty extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationError extends RecommendationState {
  final String message;

  const RecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationHasData extends RecommendationState {
  final List<Movie> result;

  const MovieRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvRecommendationHasData extends RecommendationState {
  final List<Tv> result;

  const TvRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
