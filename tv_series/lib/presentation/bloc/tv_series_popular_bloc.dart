
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries _getPopularTvSeries;

  TvSeriesPopularBloc(this._getPopularTvSeries) : super(TvSeriesPopularEmpty()) {
    on<LoadTvSeriesPopular>((event, emit) async {
      emit(TvSeriesPopularLoading());
      final result = await _getPopularTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesPopularError(failure.message)),
        (data) => emit(TvSeriesPopularHasData(data)),
      );
    });
  }
}
