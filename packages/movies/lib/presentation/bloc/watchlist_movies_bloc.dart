// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/movies.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc(this.getWatchlistMovies) : super(WatchlistEmpty()) {
    on<WatchlistMoviesData>((event, emit) async {
      emit(WatchlistLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(WatchlistError(failure.message)),
        (movies) => emit(WatchlistHasData(movies)),
      );
    });
  }
}
