import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesPopularBloc = TvSeriesPopularBloc(mockGetPopularTvSeries);
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
      'Should emit [Loading, Empty] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => const Right(<TvSeries>[]));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesPopular()),
      expect: () => [
        TvSeriesPopularLoading(),
        const TvSeriesPopularHasData(<TvSeries>[]),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      }
  );

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(LoadTvSeriesPopular()),
      expect: () => [
        TvSeriesPopularLoading(),
        const TvSeriesPopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      }
  );
}