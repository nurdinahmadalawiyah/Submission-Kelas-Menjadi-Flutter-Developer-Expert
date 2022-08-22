// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MoviePopularBloc>().add(LoadMoviePopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            if (state is MoviePopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularHasData) {
              final result = state.results;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is MoviePopularError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state is MoviePopularEmpty) {
              return const Text('Movie Popular is empty');
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
