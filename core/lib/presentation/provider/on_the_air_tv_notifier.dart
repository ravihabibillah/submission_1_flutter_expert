import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_on_the_air_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final GetOnTheAirTv getOnTheAirTv;

  OnTheAirTvNotifier({required this.getOnTheAirTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tvs = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
