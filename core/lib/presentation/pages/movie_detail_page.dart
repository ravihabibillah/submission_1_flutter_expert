import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/recommendation/bloc/recommendation_bloc.dart';
import 'package:core/presentation/bloc/watchlist/bloc/watchlist_bloc.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../provider/movie_detail_notifier.dart';
import '../../utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailBloc>(context, listen: false)
          .add(FetchMovieDetail(widget.id));
      Provider.of<WatchlistBloc>(context, listen: false)
          .add(LoadWatchlistStatus(widget.id));
      Provider.of<RecommendationBloc>(context, listen: false)
          .add(FetchMovieRecommendation(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(movie),
            );
          } else if (state is DetailError) {
            return Text(state.message);
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  // final bool isAddedWatchlist;

  DetailContent(this.movie);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            // BlocListener(listener: (_, state) {
                            //   if (state is WatchlistSuccess) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(content: Text(state.message)));
                            //   } else if (state is WatchlistFailure) {
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return AlertDialog(
                            //           content: Text(state.message),
                            //         );
                            //       },
                            //     );
                            //   }
                            // }),
                            BlocConsumer<WatchlistBloc, WatchlistState>(
                              listener: (context, state) {
                                if (state is WatchlistSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                } else if (state is WatchlistFailure) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    },
                                  );
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (state is WatchlistHasData) {
                                      if (state.isAdded == false) {
                                        context
                                            .read<WatchlistBloc>()
                                            .add(AddWatchlist(movie));
                                      } else if (state.isAdded == true) {
                                        context
                                            .read<WatchlistBloc>()
                                            .add(DeleteWatchlist(movie));
                                      }
                                    }

                                    // if (!isAddedWatchlist) {
                                    //   await Provider.of<MovieDetailNotifier>(
                                    //           context,
                                    //           listen: false)
                                    //       .addWatchlist(movie);
                                    // } else {
                                    //   await Provider.of<MovieDetailNotifier>(
                                    //           context,
                                    //           listen: false)
                                    //       .removeFromWatchlist(movie);
                                    // }

                                    // final message =
                                    //     Provider.of<WatchlistBloc>(
                                    //             context,
                                    //             listen: false)
                                    //         .add(event);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (state is WatchlistHasData)
                                        if (state.isAdded == false)
                                          Icon(Icons.add)
                                        else if (state.isAdded == true)
                                          Icon(Icons.check),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationBloc,
                                RecommendationState>(
                              builder: (context, state) {
                                if (state is RecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                    is MovieRecommendationHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
