import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/presentation/bloc/watchlist/tv_watchlist/bloc/tv_watchlist_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTvs;
  late TvWatchlistBloc tvWatchlistBloc;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(mockGetWatchlistTvs);
  });

  test('initial should be Empty', () {
    expect(tvWatchlistBloc.state, TvWatchlistEmpty());
  });

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [TvWatchlistLoading, TvWatchlistHasData] when get watchlist Tv data is successful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [TvWatchlistLoading, TvWatchlistError] when get watchlist Tv data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      const TvWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
}
