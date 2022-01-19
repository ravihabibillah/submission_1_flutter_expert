import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse({
    required this.backdropPath,
    // required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    // required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    // required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    // required this.productionCompanies,
    // required this.productionCountries,
    // required this.seasons,
    // required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  // List<CreatedBy> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  List<GenreModel> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  // LastEpisodeToAir lastEpisodeToAir;
  String name;
  dynamic nextEpisodeToAir;
  // List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  // List<Network> productionCompanies;
  // List<ProductionCountry> productionCountries;
  // List<SeasonModel> seasons;
  // List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        // createdBy: List<CreatedBy>.from(
        //     json["created_by"].map((x) => CreatedBy.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        // lastEpisodeToAir:
        //     LastEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        // networks: List<Network>.from(
        //     json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        // productionCompanies: List<Network>.from(
        //     json["production_companies"].map((x) => Network.fromJson(x))),
        // productionCountries: List<ProductionCountry>.from(
        //     json["production_countries"]
        //         .map((x) => ProductionCountry.fromJson(x))),
        // seasons: List<SeasonModel>.from(
        //     json["seasons"].map((x) => SeasonModel.fromJson(x))),
        // spokenLanguages: List<SpokenLanguage>.from(
        //     json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        // "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        // "last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        // "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        // "production_companies":
        //     List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        // "production_countries":
        //     List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        // "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        // "spoken_languages":
        //     List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: this.backdropPath,
        episodeRunTime: this.episodeRunTime,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        homepage: this.homepage,
        id: this.id,
        inProduction: this.inProduction,
        languages: this.languages,
        lastAirDate: this.lastAirDate,
        name: this.name,
        nextEpisodeToAir: this.nextEpisodeToAir,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originCountry: this.originCountry,
        originalLanguage: this.originalLanguage,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        // seasons: this.seasons.map((season) => season.toEntity()).toList(),
        status: this.status,
        tagline: this.tagline,
        type: this.type,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        // List<CreatedBy> createdBy;
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        // LastEpisodeToAir lastEpisodeToAir;
        name,
        nextEpisodeToAir,
        // List<Network> networks;
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        // List<Network> productionCompanies;
        // List<ProductionCountry> productionCountries;
        // seasons,
        // List<SpokenLanguage> spokenLanguages;
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

// class CreatedBy {
//   CreatedBy({
//     this.id,
//     this.creditId,
//     this.name,
//     this.gender,
//     this.profilePath,
//   });

//   int id;
//   String creditId;
//   String name;
//   int gender;
//   String profilePath;

//   factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
//         id: json["id"],
//         creditId: json["credit_id"],
//         name: json["name"],
//         gender: json["gender"],
//         profilePath: json["profile_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "credit_id": creditId,
//         "name": name,
//         "gender": gender,
//         "profile_path": profilePath,
//       };
// }

// class LastEpisodeToAir {
//   LastEpisodeToAir({
//     this.airDate,
//     this.episodeNumber,
//     this.id,
//     this.name,
//     this.overview,
//     this.productionCode,
//     this.seasonNumber,
//     this.stillPath,
//     this.voteAverage,
//     this.voteCount,
//   });

//   DateTime airDate;
//   int episodeNumber;
//   int id;
//   String name;
//   String overview;
//   String productionCode;
//   int seasonNumber;
//   String stillPath;
//   double voteAverage;
//   int voteCount;

//   factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
//       LastEpisodeToAir(
//         airDate: DateTime.parse(json["air_date"]),
//         episodeNumber: json["episode_number"],
//         id: json["id"],
//         name: json["name"],
//         overview: json["overview"],
//         productionCode: json["production_code"],
//         seasonNumber: json["season_number"],
//         stillPath: json["still_path"],
//         voteAverage: json["vote_average"].toDouble(),
//         voteCount: json["vote_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "air_date":
//             "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
//         "episode_number": episodeNumber,
//         "id": id,
//         "name": name,
//         "overview": overview,
//         "production_code": productionCode,
//         "season_number": seasonNumber,
//         "still_path": stillPath,
//         "vote_average": voteAverage,
//         "vote_count": voteCount,
//       };
// }

// class Network {
//   Network({
//     this.name,
//     this.id,
//     this.logoPath,
//     this.originCountry,
//   });

//   String name;
//   int id;
//   String logoPath;
//   String originCountry;

//   factory Network.fromJson(Map<String, dynamic> json) => Network(
//         name: json["name"],
//         id: json["id"],
//         logoPath: json["logo_path"] == null ? null : json["logo_path"],
//         originCountry: json["origin_country"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "id": id,
//         "logo_path": logoPath == null ? null : logoPath,
//         "origin_country": originCountry,
//       };
// }

// class ProductionCountry {
//   ProductionCountry({
//     this.iso31661,
//     this.name,
//   });

//   String iso31661;
//   String name;

//   factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
//       ProductionCountry(
//         iso31661: json["iso_3166_1"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "iso_3166_1": iso31661,
//         "name": name,
//       };
// }



// class SpokenLanguage {
//   SpokenLanguage({
//     this.englishName,
//     this.iso6391,
//     this.name,
//   });

//   String englishName;
//   String iso6391;
//   String name;

//   factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
//         englishName: json["english_name"],
//         iso6391: json["iso_639_1"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "english_name": englishName,
//         "iso_639_1": iso6391,
//         "name": name,
//       };
// }