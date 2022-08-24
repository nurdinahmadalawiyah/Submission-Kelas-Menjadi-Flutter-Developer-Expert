part of 'tv_series_detail_bloc.dart';

@immutable
abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  const FetchTvSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvSeriesWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddTvSeriesWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveTvSeriesWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveTvSeriesWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class StatusTvSeriesWatchlist extends TvSeriesDetailEvent {
  final int id;

  const StatusTvSeriesWatchlist(this.id);

  @override
  List<Object> get props => [id];
}
