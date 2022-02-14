import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/presentation/bloc/popular/bloc/popular_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies, GetPopularTv])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetPopularTv mockGetPopularTv;
  late PopularBloc popularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetPopularTv = MockGetPopularTv();
    popularBloc = PopularBloc(
      getPopularMovies: mockGetPopularMovies,
      getPopularTv: mockGetPopularTv,
    );
  });

  test('initial should be Empty', () {
    expect(popularBloc.state, PopularEmpty());
  });

  group('Popular Movies', () {
    blocTest<PopularBloc, PopularState>(
      'Should emit [PopularLoading, MoviePopularHasData] when get popular movie data is successful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(FetchMoviePopular()),
      expect: () => [
        PopularLoading(),
        MoviePopularHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularBloc, PopularState>(
      'Should emit [PopularLoading, PopularError] when get popular movie data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (bloc) => bloc.add(FetchMoviePopular()),
      expect: () => [
        PopularLoading(),
        const PopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('Popular Tv Series', () {
    blocTest<PopularBloc, PopularState>(
      'Should emit [PopularLoading, TvPopularHasData] when get popular tv series data is successful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(FetchTvPopular()),
      expect: () => [
        PopularLoading(),
        TvPopularHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularBloc, PopularState>(
      'Should emit [PopularLoading, PopularError] when get popular tv series data is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (bloc) => bloc.add(FetchTvPopular()),
      expect: () => [
        PopularLoading(),
        const PopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}
