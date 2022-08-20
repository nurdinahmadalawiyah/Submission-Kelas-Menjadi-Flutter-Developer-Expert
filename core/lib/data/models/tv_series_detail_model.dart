import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.numberEpisodes,
    required this.numberSeasons,
    required this.status,
    required this.tagline,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final int numberEpisodes;
  final int numberSeasons;
  final String status;
  final String tagline;
  final String name;
  final double voteAverage;
  final int voteCount;

 factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
       TvSeriesDetailResponse(
         adult: json["adult"],
         backdropPath: json["backdrop_path"],
         genres: List<GenreModel>.from(
             json["genres"].map((x) => GenreModel.fromJson(x))),
         homepage: json["homepage"],
         id: json["id"],
         originalLanguage: json["original_language"],
         originalName: json["original_name"],
         overview: json["overview"],
         popularity: json["popularity"].toDouble(),
         posterPath: json["poster_path"],
         firstAirDate: json["first_air_date"],
         numberEpisodes: json["number_of_episodes"],
         numberSeasons: json["number_of_seasons"],
         status: json["status"],
         tagline: json["tagline"],
         name: json["name"],
         voteAverage: json["vote_average"].toDouble(),
         voteCount: json["vote_count"],
       );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "number_of_episodes": numberEpisodes,
        "number_of_seasons": numberSeasons,
        "status": status,
        "tagline": tagline,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: this.adult,
      backdropPath: this.backdropPath,
      genres: this.genres.map((genres) => genres.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      numberEpisodes: this.numberEpisodes,
      numberSeasons: this.numberSeasons,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        homepage,
        id,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        numberEpisodes,
        numberSeasons,
        status,
        tagline,
        name,
        voteAverage,
        voteCount,
      ];
}