
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;

  TvSeriesTopRatedBloc(this._getTopRatedTvSeries) : super(TvSeriesTopRatedEmpty()) {
    on<LoadTvSeriesTopRated>((event, emit) async {
      emit(TvSeriesTopRatedLoading());
      final result = await _getTopRatedTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesTopRatedError(failure.message)),
        (data) => emit(TvSeriesTopRatedHasData(data)),
      );
    });
  }
}
