import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/presentation/bloc/detail/bloc/detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetTvDetail])
void main() {
  late DetailBloc detailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetTvDetail = MockGetTvDetail();
    detailBloc = DetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getTvDetail: mockGetTvDetail,
    );
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(detailBloc.state, DetailEmpty());
  });

  group('Movie Detail', () {
    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailHasData]  when detail data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));

        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        DetailLoading(),
        MovieDetailHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailError] when detail data is gotten unsuccessfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      wait: const Duration(microseconds: 500),
      expect: () => [
        DetailLoading(),
        const DetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Tv Series Detail', () {
    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailHasData]  when detail data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));

        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        DetailLoading(),
        TvDetailHasData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [DetailLoading, DetailError] when detail data is gotten unsuccessfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return detailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      wait: const Duration(microseconds: 500),
      expect: () => [
        DetailLoading(),
        const DetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );
  });
}
