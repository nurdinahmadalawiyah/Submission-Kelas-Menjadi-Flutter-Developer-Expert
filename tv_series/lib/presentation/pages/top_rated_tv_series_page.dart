// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesTopRatedBloc>().add(LoadTvSeriesTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesTopRatedHasData) {
              final result = state.results;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvSeriesCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is TvSeriesTopRatedError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else if (state is TvSeriesTopRatedEmpty) {
              return const Text('TV Series Top Rated is empty');
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
