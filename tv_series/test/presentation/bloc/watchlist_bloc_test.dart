import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';
import '../../dummy_data/dummy_object_tv.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  final tTvSeries = <TvSeries>[testTvSeries];

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistLoading, WatchlistHasData] when data is gotten successfuly',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeries));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvSeriesData()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData(tTvSeries),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistLoading, WatchlistEmpty] when data is empty',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(<TvSeries>[]));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvSeriesData()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData(<TvSeries>[]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [WatchlistLoading, WatchlistError] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvSeriesData()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
