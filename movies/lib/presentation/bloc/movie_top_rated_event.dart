part of 'movie_top_rated_bloc.dart';

@immutable
abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieTopRated extends MovieTopRatedEvent {
  @override
  List<Object> get props => [];
}
