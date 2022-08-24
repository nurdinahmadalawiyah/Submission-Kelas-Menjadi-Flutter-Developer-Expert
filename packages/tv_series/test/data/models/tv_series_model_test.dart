import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

void main() {
  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
    popularity: 1,
    originalName: 'originalName',
    genreIds: const [1, 2, 3],
  );

  const tTvSeriesModel = TvSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
    popularity: 1,
    originalName: 'originalName',
    genreIds: [1, 2, 3],
  );

  test('should be a subclass if Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
