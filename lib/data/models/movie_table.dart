import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class DbTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  DbTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory DbTable.fromEntity(MovieDetail movie) => DbTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory DbTable.fromMap(Map<String, dynamic> map) => DbTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
