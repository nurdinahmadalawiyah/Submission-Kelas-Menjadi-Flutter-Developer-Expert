import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatusTvSeries mockGetWatchlistStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      mockGetTvSeriesDetail,
      mockGetTvSeriesRecommendations,
      mockGetWatchlistStatusTvSeries,
      mockSaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
    );
  });

  final tId = 1;
  final tvSeriesDetailStateInit = TvSeriesDetailState.initial();
  final tTvSerie = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    name: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvSeries = <TvSeries>[tTvSerie];

  final tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    numberSeasons: 1,
    numberEpisodes: 1,
    voteAverage: 1,
    voteCount: 1,
  );

  group('Get TvSeries Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Shoud emit TvSeriesDetailLoading, RecomendationLoading, TvSeriesDetailLoaded and Recomendation Loaded when get  Detail TvSeries and Recommendation Success',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvSeriesDetail));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(detailState: RequestState.Loading),
        tvSeriesDetailStateInit.copyWith(
          recommendationsState: RequestState.Loading,
          tvSeriesDetail: tTvSeriesDetail,
          detailState: RequestState.Loaded,
          message: '',
        ),
        tvSeriesDetailStateInit.copyWith(
          detailState: RequestState.Loaded,
          tvSeriesDetail: tTvSeriesDetail,
          recommendationsState: RequestState.Loaded,
          tvSeriesRecommendations: tTvSeries,
          message: '',
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Shoud emit TvSeriesDetailLoading, RecomendationLoading, TvSeriesDetailLoaded and RecommendationError when Get TvSeriesRecommendations Failed',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvSeriesDetail));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(detailState: RequestState.Loading),
        tvSeriesDetailStateInit.copyWith(
          recommendationsState: RequestState.Loading,
          tvSeriesDetail: tTvSeriesDetail,
          detailState: RequestState.Loaded,
          message: '',
        ),
        tvSeriesDetailStateInit.copyWith(
          detailState: RequestState.Loaded,
          tvSeriesDetail: tTvSeriesDetail,
          recommendationsState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Shoud emit TvSeriesDetailError when Get TvSeries Detail Failed',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(detailState: RequestState.Loading),
        tvSeriesDetailStateInit.copyWith(
            detailState: RequestState.Error, message: 'Failed'),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );
  });

  group('AddToWatchlist TvSeries', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatusTvSeries.execute(tTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesWatchlist(tTvSeriesDetail)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(message: 'Added to Watchlist'),
        tvSeriesDetailStateInit.copyWith(
            message: 'Added to Watchlist', isAddedtoWatchlist: true),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail));
        verify(mockGetWatchlistStatusTvSeries.execute(tTvSeriesDetail.id));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Shoud emit watchlist Message when Failed',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatusTvSeries.execute(tTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddTvSeriesWatchlist(tTvSeriesDetail)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(message: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail));
        verify(mockGetWatchlistStatusTvSeries.execute(tTvSeriesDetail.id));
      },
    );
  });

  group('RemoveFromWatchlist TvSeries', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatusTvSeries.execute(tTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveTvSeriesWatchlist(tTvSeriesDetail)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(message: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail));
        verify(mockGetWatchlistStatusTvSeries.execute(tTvSeriesDetail.id));
      },
    );
  });

  group('LoadWatchlistStatus', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should Emit AddWatchlistStatus True',
      build: () {
        when(mockGetWatchlistStatusTvSeries.execute(tId)).thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(StatusTvSeriesWatchlist(tId)),
      expect: () => [
        tvSeriesDetailStateInit.copyWith(isAddedtoWatchlist: true),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatusTvSeries.execute(tTvSeriesDetail.id));
      },
    );
  });
}
