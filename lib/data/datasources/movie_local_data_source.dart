import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(DbTable movie);
  Future<String> removeWatchlist(DbTable movie);
  Future<String> insertWatchlistTv(TvTable tv);
  Future<String> removeWatchlistTv(TvTable tv);
  Future<DbTable?> getById(int id);
  Future<List<DbTable>> getWatchlist();
  Future<List<TvTable>> getTvWatchlist();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(DbTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(DbTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertWatchlistTv(TvTable tv) async {
    try {
      await databaseHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<DbTable?> getById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return DbTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<DbTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => DbTable.fromMap(data)).toList();
  }

  @override
  Future<List<TvTable>> getTvWatchlist() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
