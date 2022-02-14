import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/watchlist/bloc/watchlist_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    watchlistBloc = WatchlistBloc(
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      removeWatchlistTv: mockRemoveWatchlistTv,
      saveWatchlistTv: mockSaveWatchlistTv,
    );
  });

  const tId = 1;

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [WatchlistHasData] when get the watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [const WatchlistHasData(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
  group('Movie Watchlist', () {
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistSuccess] when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistSuccess('Added to Watchlist'),
        const WatchlistHasData(false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistFailure] when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistFailure('Failed'),
        const WatchlistHasData(false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistSuccess] when remove watchlist success',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);

        return watchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteMovieWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistSuccess('Removed from Watchlist'),
        const WatchlistHasData(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistFailure] when remove watchlist failed',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteMovieWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistFailure('Failed'),
        const WatchlistHasData(true),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });

  group('Tv Series Watchlist', () {
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistSuccess] when add watchlist success',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddTvWatchlist(testTvDetail)),
      expect: () => [
        const WatchlistSuccess('Added to Watchlist'),
        const WatchlistHasData(false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistFailure] when add watchlist failed',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(AddTvWatchlist(testTvDetail)),
      expect: () => [
        const WatchlistFailure('Failed'),
        const WatchlistHasData(false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistSuccess] when remove watchlist success',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);

        return watchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteTvWatchlist(testTvDetail)),
      expect: () => [
        const WatchlistSuccess('Removed from Watchlist'),
        const WatchlistHasData(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [WatchlistFailure] when remove watchlist failed',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteTvWatchlist(testTvDetail)),
      expect: () => [
        const WatchlistFailure('Failed'),
        const WatchlistHasData(true),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );
  });
}
