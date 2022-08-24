part of 'watchlist_tv_series_bloc.dart';

@immutable
abstract class WatchlistTvSeriesState extends Equatable{
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState{}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState{}

class WatchlistTvSeriesError extends WatchlistTvSeriesState{
  final String message;

  const WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesHasData extends WatchlistTvSeriesState{
  final List<TvSeries> results;

  const WatchlistTvSeriesHasData(this.results);

  @override
  List<Object> get props => [results];
}
