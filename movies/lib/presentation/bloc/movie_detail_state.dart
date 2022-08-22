part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final List<Movie> movieRecommendations;
  final RequestState detailState;
  final RequestState recommendationsState;
  final String message;
  final bool isAddedtoWatchlist;

  MovieDetailState({
    required this.movieDetail,
    required this.movieRecommendations,
    required this.detailState,
    required this.recommendationsState,
    required this.message,
    required this.isAddedtoWatchlist,
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    RequestState? detailState,
    RequestState? recommendationsState,
    String? message,
    bool? isAddedtoWatchlist,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      detailState: detailState ?? this.detailState,
      recommendationsState: recommendationsState ?? this.recommendationsState,
      message: message ?? this.message,
      isAddedtoWatchlist: isAddedtoWatchlist ?? this.isAddedtoWatchlist,
    );
  }

  factory MovieDetailState.initial() {
    return MovieDetailState(
      movieDetail: null,
      movieRecommendations: [],
      detailState: RequestState.Empty,
      recommendationsState: RequestState.Empty,
      message: '',
      isAddedtoWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        movieRecommendations,
        detailState,
        recommendationsState,
        message,
        isAddedtoWatchlist,
      ];
}
