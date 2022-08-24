part of 'movie_top_rated_bloc.dart';

@immutable
abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedEmpty extends MovieTopRatedState {}

class MovieTopRatedLoading extends MovieTopRatedState {}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> results;

  const MovieTopRatedHasData(this.results);

  @override
  List<Object> get props => [results];
}
