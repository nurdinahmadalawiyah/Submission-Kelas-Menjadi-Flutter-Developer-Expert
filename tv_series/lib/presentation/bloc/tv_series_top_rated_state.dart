part of 'tv_series_top_rated_bloc.dart';

@immutable
abstract class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class TvSeriesTopRatedEmpty extends TvSeriesTopRatedState {}

class TvSeriesTopRatedLoading extends TvSeriesTopRatedState {}

class TvSeriesTopRatedError extends TvSeriesTopRatedState {
  final String message;

  const TvSeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesTopRatedHasData extends TvSeriesTopRatedState {
  final List<TvSeries> results;

  const TvSeriesTopRatedHasData(this.results);

  @override
  List<Object> get props => [results];
}
