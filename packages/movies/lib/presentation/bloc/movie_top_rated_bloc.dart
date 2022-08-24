// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedEmpty()) {
   on<LoadMovieTopRated>((event, emit) async {
     emit(MovieTopRatedLoading());
     final result = await _getTopRatedMovies.execute();

     result.fold(
       (failure) => emit(MovieTopRatedError(failure.message)),
       (data) => emit(MovieTopRatedHasData(data)),
     );
   });
  }
}
