part of 'tv_series_popular_bloc.dart';

@immutable
abstract class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object> get props => [];
}

class TvSeriesPopularEmpty extends TvSeriesPopularState {}

class TvSeriesPopularLoading extends TvSeriesPopularState {}

class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;

  const TvSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesPopularHasData extends TvSeriesPopularState {
  final List<TvSeries> results;

  const TvSeriesPopularHasData(this.results);

  @override
  List<Object> get props => [results];
}
