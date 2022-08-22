
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvSeriesDetailBloc(
    this.getTvSeriesDetail,
    this.getTvSeriesRecommendations,
    this.getWatchListStatusTvSeries,
    this.saveWatchlistTvSeries,
    this.removeWatchlistTvSeries,
  ) : super(TvSeriesDetailState.initial()) {
    on<FetchTvSeriesDetail>(
      (event, emit) async {
        emit(state.copyWith(detailState: RequestState.Loading));
        final detailResult = await getTvSeriesDetail.execute(event.id);
        final recommendationResult =
            await getTvSeriesRecommendations.execute(event.id);

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
              tvSeriesDetail: detail,
            ));
            recommendationResult.fold(
              (failure) {
                emit(state.copyWith(
                  recommendationsState: RequestState.Error,
                  message: failure.message,
                ));
              },
              (tvSeriesRecommendations) {
                emit(state.copyWith(
                  recommendationsState: RequestState.Loaded,
                  message: '',
                  tvSeriesRecommendations: tvSeriesRecommendations,
                ));
              },
            );
          },
        );
      },
    );
    on<AddTvSeriesWatchlist>(
      (event, emit) async {
        final watchlistResult =
            await saveWatchlistTvSeries.execute(event.tvSeriesDetail);

        watchlistResult.fold(
          (failure) => emit(state.copyWith(message: failure.message)),
          (success) =>
              emit(state.copyWith(message: watchlistAddSuccessMessage)),
        );
        add(StatusTvSeriesWatchlist(event.tvSeriesDetail.id));
      },
    );
    on<RemoveTvSeriesWatchlist>(
      (event, emit) async {
        final watchlistResult =
            await removeWatchlistTvSeries.execute(event.tvSeriesDetail);

        watchlistResult.fold(
          (failure) => emit(state.copyWith(message: failure.message)),
          (success) =>
              emit(state.copyWith(message: watchlistRemoveSuccessMessage)),
        );
        add(StatusTvSeriesWatchlist(event.tvSeriesDetail.id));
      },
    );
    on<StatusTvSeriesWatchlist>(
      (event, emit) async {
        final watchlistResult =
            await getWatchListStatusTvSeries.execute(event.id);
        emit(state.copyWith(isAddedtoWatchlist: watchlistResult));
      },
    );
  }
}
