import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/bloc/search_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTv])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTv = MockSearchTv();
    searchBloc = SearchBloc(
      searchMovies: mockSearchMovies,
      searchTv: mockSearchTv,
    );
  });

  // Data for Search Movie

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  // Data for Search Tv

  final tTvModel = Tv(
      posterPath: "/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg",
      popularity: 29.780826,
      id: 1399,
      backdropPath: "/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg",
      voteAverage: 7.91,
      overview:
          "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
      originCountry: const ["US"],
      genreIds: const [10765, 10759, 18],
      originalLanguage: "en",
      voteCount: 1172,
      name: "Game of Thrones",
      originalName: "Game of Thrones");

  final tTvList = <Tv>[tTvModel];
  const tTvQuery = 'game of thrones';

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });
  group('Search Movies', () {
    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnMovieQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emot [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnMovieQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });

  group('Search Tv Series', () {
    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTv.execute(tTvQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnTvQueryChanged(tTvQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tTvQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emot [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTv.execute(tTvQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnTvQueryChanged(tTvQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tTvQuery));
      },
    );
  });
}
