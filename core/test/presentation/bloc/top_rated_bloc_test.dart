import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/presentation/bloc/top_rated/bloc/top_rated_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies, GetTopRatedTv])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedBloc = TopRatedBloc(
        getTopRatedMovies: mockGetTopRatedMovies,
        getTopRatedTv: mockGetTopRatedTv);
  });

  test('initial should be Empty', () {
    expect(topRatedBloc.state, TopRatedEmpty());
  });

  group('Top Rated Movies', () {
    blocTest<TopRatedBloc, TopRatedState>(
      'Should emit [TopRatedLoading, MovieTopRatedHasData] when get top rated movie data is successful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(FetchMovieTopRated()),
      expect: () => [
        TopRatedLoading(),
        MovieTopRatedHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedBloc, TopRatedState>(
      'Should emit [TopRatedLoading, TopRatedError] when get top rated movie data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(FetchMovieTopRated()),
      expect: () => [
        TopRatedLoading(),
        const TopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('Top Rated Tv Series', () {
    blocTest<TopRatedBloc, TopRatedState>(
      'Should emit [TopRatedLoading, TvTopRatedHasData] when get top rated tv series data is successful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTvTopRated()),
      expect: () => [
        TopRatedLoading(),
        TvTopRatedHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedBloc, TopRatedState>(
      'Should emit [TopRatedLoading, TopRatedError] when get top rated tv series data is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTvTopRated()),
      expect: () => [
        TopRatedLoading(),
        const TopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}
