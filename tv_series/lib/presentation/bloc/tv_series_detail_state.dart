part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  final TvSeriesDetail? tvSeriesDetail;
  final List<TvSeries> tvSeriesRecommendations;
  final RequestState detailState;
  final RequestState recommendationsState;
  final String message;
  final bool isAddedtoWatchlist;

  TvSeriesDetailState({
    required this.tvSeriesDetail,
    required this.tvSeriesRecommendations,
    required this.detailState,
    required this.recommendationsState,
    required this.message,
    required this.isAddedtoWatchlist,
  });

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeriesDetail,
    List<TvSeries>? tvSeriesRecommendations,
    RequestState? detailState,
    RequestState? recommendationsState,
    String? message,
    bool? isAddedtoWatchlist,
  }) {
    return TvSeriesDetailState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesRecommendations: tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      detailState: detailState ?? this.detailState,
      recommendationsState: recommendationsState ?? this.recommendationsState,
      message: message ?? this.message,
      isAddedtoWatchlist: isAddedtoWatchlist ?? this.isAddedtoWatchlist,
    );
  }

  factory TvSeriesDetailState.initial() {
    return TvSeriesDetailState(
      tvSeriesDetail: null,
      tvSeriesRecommendations: [],
      detailState: RequestState.Empty,
      recommendationsState: RequestState.Empty,
      message: '',
      isAddedtoWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        tvSeriesDetail,
        tvSeriesRecommendations,
        detailState,
        recommendationsState,
        message,
        isAddedtoWatchlist,
      ];
}

