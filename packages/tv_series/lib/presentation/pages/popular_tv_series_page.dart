// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesPopularBloc>().add(LoadTvSeriesPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesPopularHasData) {
              final result = state.results;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvSeriesCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is TvSeriesPopularError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is TvSeriesPopularEmpty) {
              return const Text('TV Series Popular is empty');
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
