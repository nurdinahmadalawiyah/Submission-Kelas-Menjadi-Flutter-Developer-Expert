// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class HomeTVSeriesPage extends StatefulWidget {
  @override
  _HomeTVSeriesPageState createState() => _HomeTVSeriesPageState();
}

class _HomeTVSeriesPageState extends State<HomeTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesListBloc>().add(LoadTvSeriesList());
    context.read<TvSeriesPopularBloc>().add(LoadTvSeriesPopular());
    context.read<TvSeriesTopRatedBloc>().add(LoadTvSeriesTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                  builder: (context, state) {
                if (state is TvSeriesListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesListHasData) {
                  final result = state.results;
                  return TvSeriesList(result);
                } else if (state is TvSeriesListError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
                  builder: (context, state) {
                if (state is TvSeriesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesPopularHasData) {
                  final result = state.results;
                  return TvSeriesList(result);
                } else if (state is TvSeriesPopularError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
                  builder: (context, state) {
                if (state is TvSeriesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesTopRatedHasData) {
                  final result = state.results;
                  return TvSeriesList(result);
                } else if (state is TvSeriesTopRatedError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
