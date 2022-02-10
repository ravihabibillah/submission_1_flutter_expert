import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/top_rated/bloc/top_rated_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  test('initial should be Empty', () {
    expect(topRatedBloc.state, TopRatedEmpty());
  });

  blocTest<TopRatedBloc, TopRatedState>(
    'Should emit [TopRatedLoading, MovieTopRatedHasData] when get now playing movie data is successful',
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
    'Should emit [TopRatedLoading, TopRatedError] when get now playing movie data is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchMovieTopRated()),
    expect: () => [
      TopRatedLoading(),
      TopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
