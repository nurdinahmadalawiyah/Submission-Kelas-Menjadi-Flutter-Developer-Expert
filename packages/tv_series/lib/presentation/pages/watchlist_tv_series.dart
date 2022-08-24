import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class WatchlistTvSeries extends StatelessWidget {
  const WatchlistTvSeries({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        builder: (context, state) {
          if (state is WatchlistTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvSeriesHasData) {
            final result = state.results;
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = result[index];
                return TvSeriesCard(tv);
              },
              itemCount: result.length,
            );
          } else if (state is WatchlistTvSeriesError) {
            return Expanded(
              child: Center(
                child: Text(state.message),
              ),
            );
          } else if (state is WatchlistTvSeriesEmpty) {
            return const Center(child: Text('Watchlist is empty'));
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }
}