part of 'watchlist_movies_bloc.dart';

@immutable
abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesData extends WatchlistMoviesEvent {
  @override
  List<Object> get props => [];
}
