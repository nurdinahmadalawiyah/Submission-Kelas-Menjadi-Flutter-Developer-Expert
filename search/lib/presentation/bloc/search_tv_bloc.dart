import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvBloc(this._searchTvSeries) : super(SearchTvEmpty()) {
    on<OnQueryTvChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
            (failure) {
          emit(SearchTvError(failure.message));
        },
            (data) {
          emit(SearchTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}