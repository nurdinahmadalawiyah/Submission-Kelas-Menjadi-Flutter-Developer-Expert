import 'package:core/data/models/tv_series_model.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

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
    genreIds: [1, 2, 3],
  );

  final tTvSeriesModel = TvSeriesModel(
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
