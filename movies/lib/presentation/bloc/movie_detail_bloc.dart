
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/movies.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        emit(state.copyWith(detailState: RequestState.Loading));
        final detailResult = await getMovieDetail.execute(event.id);
        final recommendationResult =
            await getMovieRecommendations.execute(event.id);

        detailResult.fold(
          (failure) {
            emit(state.copyWith(
              detailState: RequestState.Error,
              message: failure.message,
            ));
          },
          (detail) {
            emit(state.copyWith(
              recommendationsState: RequestState.Loading,
              message: '',
              detailState: RequestState.Loaded,
              movieDetail: detail,
            ));
            recommendationResult.fold(
              (failure) {
                emit(state.copyWith(
                  recommendationsState: RequestState.Error,
                  message: failure.message,
                ));
              },
              (movieRecommendations) {
                emit(state.copyWith(
                  recommendationsState: RequestState.Loaded,
                  message: '',
                  movieRecommendations: movieRecommendations,
                ));
              },
            );
          },
        );
      },
    );
    on<AddMovieWatchlist>(
      (event, emit) async {
        final watchlistResult = await saveWatchlist.execute(event.movieDetail);

        watchlistResult.fold(
          (failure) => emit(state.copyWith(message: failure.message)),
          (success) =>
              emit(state.copyWith(message: watchlistAddSuccessMessage)),
        );
        add(StatusMovieWatchlist(event.movieDetail.id));
      },
    );
    on<RemoveMovieWatchlist>(
      (event, emit) async {
        final watchlistResult =
            await removeWatchlist.execute(event.movieDetail);

        watchlistResult.fold(
          (failure) => emit(state.copyWith(message: failure.message)),
          (success) =>
              emit(state.copyWith(message: watchlistRemoveSuccessMessage)),
        );
        add(StatusMovieWatchlist(event.movieDetail.id));
      },
    );
    on<StatusMovieWatchlist>(
      (event, emit) async {
        final watchlistResult = await getWatchListStatus.execute(event.id);
        emit(state.copyWith(isAddedtoWatchlist: watchlistResult));
      },
    );
  }
}
