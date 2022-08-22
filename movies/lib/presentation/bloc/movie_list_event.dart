part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieList extends MovieListEvent {
  @override
  List<Object> get props => [];
}
