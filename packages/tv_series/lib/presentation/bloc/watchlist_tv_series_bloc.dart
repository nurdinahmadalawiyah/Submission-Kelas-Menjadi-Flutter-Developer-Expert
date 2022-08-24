// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this.getWatchlistTvSeries) : super(WatchlistTvSeriesEmpty()) {
    on<WatchlistTvSeriesData>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await getWatchlistTvSeries.execute();

      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure.message)),
        (tvSeries) => emit(WatchlistTvSeriesHasData(tvSeries)),
      );
    });
  }
}
