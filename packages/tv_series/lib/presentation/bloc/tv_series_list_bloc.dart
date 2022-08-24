// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_list_event.dart';
part 'tv_series_list_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;

  TvSeriesListBloc(this._getNowPlayingTvSeries) : super(TvSeriesListEmpty()) {
    on<LoadTvSeriesList>((event, emit) async {
      emit(TvSeriesListLoading());
      final result = await _getNowPlayingTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesListError(failure.message)),
        (data) => emit(TvSeriesListHasData(data)),
      );
    });
  }
}
