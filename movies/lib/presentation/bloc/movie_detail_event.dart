part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable{
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent{
  final int id;

  const FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class StatusMovieWatchlist extends MovieDetailEvent {
  final int id;

  const StatusMovieWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

