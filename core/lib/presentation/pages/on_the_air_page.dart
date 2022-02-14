import 'package:core/presentation/bloc/now_playing/bloc/now_playing_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the_air-tv';

  @override
  _OnTheAirTvPageState createState() => _OnTheAirTvPageState();
}

class _OnTheAirTvPageState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<NowPlayingBloc>(context, listen: false)
        .add(FetchTvOnTheAir()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvOnTheAirHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
