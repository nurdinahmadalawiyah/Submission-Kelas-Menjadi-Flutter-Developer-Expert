import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';

import '../../dummy_data/dummy_object_tv.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseTvHelper mockDatabaseTvHelper;

  setUp(() {
    mockDatabaseTvHelper = MockDatabaseTvHelper();
    dataSource = TvSeriesLocalDataSourceImpl(databaseTvHelper: mockDatabaseTvHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success', () async {
      // arrange
      when(mockDatabaseTvHelper.insertTvWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseTvHelper.insertTvWatchlist(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}