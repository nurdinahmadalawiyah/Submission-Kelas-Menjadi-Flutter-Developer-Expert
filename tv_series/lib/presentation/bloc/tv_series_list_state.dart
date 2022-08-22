part of 'tv_series_list_bloc.dart';

@immutable
abstract class TvSeriesListState extends Equatable {
  const TvSeriesListState();

  @override
  List<Object> get props => [];
}

class TvSeriesListEmpty extends TvSeriesListState {}

class TvSeriesListLoading extends TvSeriesListState {}

class TvSeriesListError extends TvSeriesListState {
  final String message;

  const TvSeriesListError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesListHasData extends TvSeriesListState {
  final List<TvSeries> results;

  const TvSeriesListHasData(this.results);

  @override
  List<Object> get props => [results];
}
