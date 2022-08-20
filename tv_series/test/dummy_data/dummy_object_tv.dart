import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
  backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
  genreIds: [16, 10765, 10759, 18],
  id: 94605,
  originalName: 'Arcane',
  overview: 'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
  popularity: 107.593,
  posterPath: '/xQ6GijOFnxTyUzqiwGpVxgfcgqI.jpg',
  firstAirDate: '2021-11-06',
  name: 'Arcane',
  voteAverage: 9.066,
  voteCount: 2311,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  numberSeasons: 2,
  numberEpisodes: 10,
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
