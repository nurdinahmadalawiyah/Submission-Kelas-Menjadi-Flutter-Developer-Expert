part of 'tv_series_list_bloc.dart';

@immutable
abstract class TvSeriesListEvent extends Equatable {
  const TvSeriesListEvent();

  @override
  List<Object> get props => [];
}

class LoadTvSeriesList extends TvSeriesListEvent {
  @override
  List<Object> get props => [];
}
