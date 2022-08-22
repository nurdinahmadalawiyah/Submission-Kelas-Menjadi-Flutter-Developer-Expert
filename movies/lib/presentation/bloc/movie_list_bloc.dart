
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieListBloc(this._getNowPlayingMovies) : super(MovieListEmpty()) {
    on<LoadMovieList>((event, emit) async {
      emit(MovieListLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(MovieListError(failure.message)),
        (data) => emit(MovieListHasData(data)),
      );
    });
  }
}
