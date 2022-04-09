import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  final String? type;

  TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.type,
  });

  factory TvTable.fromEntity(TvDetail movie) => TvTable(
      id: movie.id,
      name: movie.name,
      posterPath: movie.posterPath,
      overview: movie.overview,
      type: 'tv');

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
      id: map['id'],
      name: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      type: map['type']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'posterPath': posterPath,
        'overview': overview,
        'type': type,
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
