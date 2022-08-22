import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2019-07-09",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvSeries = TvSeries(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2019-07-09",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing TvSeries', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getNowPlayingTvSeries();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingTvSeries();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowPlayingTvSeries();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvSeries());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular TvSeries', () {
    test('should return tv series list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated TV Series', () {
    test('should return tv series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get TvSeries Detail', () {
    final tId = 1;
    final tTvSeriesResponse = TvSeriesDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1,
      voteCount: 1,
      numberSeasons: 2,
      numberEpisodes: 10,
      name: 'name',
      originalName: 'originalName',
      firstAirDate: 'firstAirDate',
    );

    test(
        'should return TV Series data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenAnswer((_) async => tTvSeriesResponse);
          // act
          final result = await repository.getTvSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Right(testTvSeriesDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvSeriesDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get TvSeries Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
              .thenAnswer((_) async => tTvSeriesList);
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvSeriesList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvSeriesRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach TV Series', () {
    final tQuery = 'arcane';

    test('should return tv series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery))
              .thenAnswer((_) async => tTvSeriesModelList);
          // act
          final result = await repository.searchTvSeries(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvSeriesList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTvSeries(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTvSeries(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
