import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(DbTable movie);
  Future<String> removeWatchlist(DbTable movie);
  Future<DbTable?> getById(int id);
  Future<List<DbTable>> getWatchlist();
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
}
