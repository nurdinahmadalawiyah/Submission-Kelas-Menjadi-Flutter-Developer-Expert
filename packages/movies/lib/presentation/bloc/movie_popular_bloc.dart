// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(MoviePopularEmpty()) {
    on<LoadMoviePopular>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) => emit(MoviePopularError(failure.message)),
        (data) => emit(MoviePopularHasData(data)),
      );
    });
  }
}
