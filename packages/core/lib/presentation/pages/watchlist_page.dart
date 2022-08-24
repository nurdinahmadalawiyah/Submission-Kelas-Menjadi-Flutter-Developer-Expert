// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, library_private_types_in_public_api

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvSeriesBloc>().add(WatchlistTvSeriesData());
    context.read<WatchlistMoviesBloc>().add(WatchlistMoviesData());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(WatchlistTvSeriesData());
    context.read<WatchlistMoviesBloc>().add(WatchlistMoviesData());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV Series'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            WatchlistMovies(),
            WatchlistTvSeries(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
