import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../domain/entities/tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTv _getWatchlistTv;
  TvWatchlistBloc(this._getWatchlistTv) : super(TvWatchlistEmpty()) {
    on<FetchTvWatchlist>((event, emit) async {
      emit(TvWatchlistLoading());

      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) => emit(TvWatchlistError(failure.message)),
        (data) => emit(TvWatchlistHasData(data)),
      );
    });
  }
}
