import 'package:core/presentation/bloc/watchlist/movie_watchlist/bloc/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/watchlist/tv_watchlist/bloc/tv_watchlist_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware, TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() =>
        Provider.of<MovieWatchlistBloc>(context, listen: false)
            .add(FetchMovieWatchlist()));
    Future.microtask(() => Provider.of<TvWatchlistBloc>(context, listen: false)
        .add(FetchTvWatchlist()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() =>
        Provider.of<MovieWatchlistBloc>(context, listen: false)
            .add(FetchMovieWatchlist()));
    Future.microtask(() => Provider.of<TvWatchlistBloc>(context, listen: false)
        .add(FetchTvWatchlist()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Text("Movies"),
          Text("Tv Series"),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(controller: _tabController, children: [
          BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
            builder: (context, state) {
              if (state is MovieWatchlistLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieWatchlistHasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = state.result[index];
                          return MovieCard(movie);
                        },
                        itemCount: state.result.length,
                      ),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.all(16.0),
                    //   child: Text(
                    //     'Tv Series',
                    //     style: TextStyle(fontSize: 16),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemBuilder: (context, index) {
                    //       final tv = data.watchlistTv[index];
                    //       return TvCard(tv);
                    //     },
                    //     itemCount: data.watchlistTv.length,
                    //   ),
                    // ),
                  ],
                );
              } else if (state is MovieWatchlistError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              } else {
                return const Center();
              }
            },
          ),
          BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
            builder: (context, state) {
              if (state is TvWatchlistLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvWatchlistHasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final tv = state.result[index];
                          return TvCard(tv);
                        },
                        itemCount: state.result.length,
                      ),
                    ),
                  ],
                );
              } else if (state is TvWatchlistError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              } else {
                return const Center();
              }
            },
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _tabController.dispose();
    super.dispose();
  }
}
