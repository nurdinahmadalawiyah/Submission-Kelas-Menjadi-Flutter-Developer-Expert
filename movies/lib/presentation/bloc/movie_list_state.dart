part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListError extends MovieListState {
  final String message;

  const MovieListError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasData extends MovieListState {
  final List<Movie> results;

  const MovieListHasData(this.results);

  @override
  List<Object> get props => [results];
}
