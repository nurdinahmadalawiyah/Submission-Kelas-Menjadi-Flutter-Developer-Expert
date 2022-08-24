part of 'watchlist_movies_bloc.dart';

@immutable
abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistMoviesState {}

class WatchlistLoading extends WatchlistMoviesState {}

class WatchlistError extends WatchlistMoviesState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistMoviesState {
  final List<Movie> results;

  const WatchlistHasData(this.results);

  @override
  List<Object> get props => [results];
}
