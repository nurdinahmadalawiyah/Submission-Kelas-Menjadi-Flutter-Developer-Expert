import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListBloc tvSeriesListBloc;
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesListBloc = TvSeriesListBloc(mockGetNowPlayingTvSeries);
    tvSeriesPopularBloc = TvSeriesPopularBloc(mockGetPopularTvSeries);
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvSeries);
  });

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    voteAverage: 1,
    voteCount: 1,  name: 'name',
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('now playing tv series', () {
    test('initialState should be Empty', () {
      expect(tvSeriesListBloc.state, TvSeriesListEmpty());
    });

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesList()),
      expect: () => [
        TvSeriesListLoading(),
        TvSeriesListHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesList()),
      expect: () => [
        TvSeriesListLoading(),
        TvSeriesListError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });

  group('popular tv series', () {
    test('initialState should be Empty', () {
      expect(tvSeriesPopularBloc.state, TvSeriesPopularEmpty());
    });

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesPopular()),
      expect: () => [
        TvSeriesPopularLoading(),
        TvSeriesPopularHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesPopular()),
      expect: () => [
        TvSeriesPopularLoading(),
        TvSeriesPopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });

  group('top rated tv series', () {
    test('initialState should be Empty', () {
      expect(tvSeriesTopRatedBloc.state, TvSeriesTopRatedEmpty());
    });

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesTopRated()),
      expect: () => [
        TvSeriesTopRatedLoading(),
        TvSeriesTopRatedHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesTopRated()),
      expect: () => [
        TvSeriesTopRatedLoading(),
        TvSeriesTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}




