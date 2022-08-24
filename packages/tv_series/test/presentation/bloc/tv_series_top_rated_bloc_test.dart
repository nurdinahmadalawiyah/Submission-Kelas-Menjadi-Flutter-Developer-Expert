import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvSeries);
  });

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
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
    'Should emit [Loading, Empty] when data is gotten unsuccessfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Right(<TvSeries>[]));
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(LoadTvSeriesTopRated()),
    expect: () => [
      TvSeriesTopRatedLoading(),
      const TvSeriesTopRatedHasData(<TvSeries>[]),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(LoadTvSeriesTopRated()),
    expect: () => [
      TvSeriesTopRatedLoading(),
      const TvSeriesTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
