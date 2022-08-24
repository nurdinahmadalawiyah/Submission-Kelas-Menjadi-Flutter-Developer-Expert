part of 'movie_popular_bloc.dart';

@immutable
abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();

  @override
  List<Object> get props => [];
}

class LoadMoviePopular extends MoviePopularEvent {
  @override
  List<Object> get props => [];
}
