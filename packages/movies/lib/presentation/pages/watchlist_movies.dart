import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/watchlist_movies_bloc.dart';

class WatchlistMovies extends StatelessWidget {
  const WatchlistMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistHasData) {
            final result = state.results;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            );
          } else if (state is WatchlistError) {
            return Expanded(
              child: Center(
                child: Text(state.message),
              ),
            );
          } else if (state is WatchlistEmpty) {
            return const Center(child: Text('Watchlist is empty'));
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }
}
