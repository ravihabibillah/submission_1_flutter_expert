import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/presentation/bloc/recommendation/bloc/recommendation_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
  GetTvRecommendations,
])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late RecommendationBloc recommendationBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetTvRecommendations = MockGetTvRecommendations();
    recommendationBloc = RecommendationBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
      getTvRecommendations: mockGetTvRecommendations,
    );
  });

  const tId = 1;

  test('initial should be empty', () {
    expect(recommendationBloc.state, RecommendationEmpty());
  });

  group('Movie Recommendations', () {
    blocTest<RecommendationBloc, RecommendationState>(
      'Should emit [RecommendationLoading, MovieRecommendationHasData] when get movie recommendation data is successful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));

        return recommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieRecommendation(tId)),
      expect: () => [
        RecommendationLoading(),
        MovieRecommendationHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<RecommendationBloc, RecommendationState>(
      'Should emit [RecommendationLoading, RecommendationError] when get movie recommendation data is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return recommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieRecommendation(tId)),
      expect: () => [
        RecommendationLoading(),
        const RecommendationError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Tv Series Recommendations', () {
    blocTest<RecommendationBloc, RecommendationState>(
      'Should emit [RecommendationLoading, MovieRecommendationHasData] when get recommendation data is successful',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvList));

        return recommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchTvRecommendation(tId)),
      expect: () => [
        RecommendationLoading(),
        TvRecommendationHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<RecommendationBloc, RecommendationState>(
      'Should emit [RecommendationLoading, RecommendationError] when get recommendation data is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return recommendationBloc;
      },
      act: (bloc) => bloc.add(const FetchTvRecommendation(tId)),
      expect: () => [
        RecommendationLoading(),
        const RecommendationError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });
}
