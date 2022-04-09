import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_on_the_air_tv.dart';
import 'package:core/presentation/bloc/now_playing/bloc/now_playing_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetOnTheAirTv])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late NowPlayingBloc nowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    nowPlayingBloc = NowPlayingBloc(
        getNowPlayingMovies: mockGetNowPlayingMovies,
        getOnTheAirTv: mockGetOnTheAirTv);
  });

  test('initial should be Empty', () {
    expect(nowPlayingBloc.state, NowPlayingEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<NowPlayingBloc, NowPlayingState>(
      'Should emit [NowPlayingLoading, MovieNowPlayingHasData] when get now playing movie data is successful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchMovieNowPlaying()),
      expect: () => [
        NowPlayingLoading(),
        MovieNowPlayingHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingBloc, NowPlayingState>(
      'Should emit [NowPlayingLoading, NowPlayingError] when get now playing movie data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchMovieNowPlaying()),
      expect: () => [
        NowPlayingLoading(),
        const NowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('On The Air Tv Series', () {
    blocTest<NowPlayingBloc, NowPlayingState>(
      'Should emit [NowPlayingLoading, TvOnTheAirHasData] when get now playing tv series data is successful',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvOnTheAir()),
      expect: () => [
        NowPlayingLoading(),
        TvOnTheAirHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );

    blocTest<NowPlayingBloc, NowPlayingState>(
      'Should emit [NowPlayingLoading, NowPlayingError] when get on the air tv series data is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvOnTheAir()),
      expect: () => [
        NowPlayingLoading(),
        const NowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );
  });
}
