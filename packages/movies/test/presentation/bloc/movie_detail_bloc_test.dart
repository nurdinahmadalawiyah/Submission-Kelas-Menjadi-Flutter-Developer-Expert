import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/genre.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final movieDetailStateInit = MovieDetailState.initial();
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit MovieDetailLoading, RecomendationLoading, MovieDetailLoaded and RecomendationLoaded when get  Detail Movies and Recommendation Success',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(tMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        movieDetailStateInit.copyWith(detailState: RequestState.Loading),
        movieDetailStateInit.copyWith(
          recommendationsState: RequestState.Loading,
          movieDetail: tMovieDetail,
          detailState: RequestState.Loaded,
          message: '',
        ),
        movieDetailStateInit.copyWith(
          detailState: RequestState.Loaded,
          movieDetail: tMovieDetail,
          recommendationsState: RequestState.Loaded,
          movieRecommendations: tMovies,
          message: '',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit MovieDetailLoading, RecomendationLoading, MovieDetailLoaded and RecommendationError when Get MovieRecommendations Failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(tMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        movieDetailStateInit.copyWith(detailState: RequestState.Loading),
        movieDetailStateInit.copyWith(
          recommendationsState: RequestState.Loading,
          movieDetail: tMovieDetail,
          detailState: RequestState.Loaded,
          message: '',
        ),
        movieDetailStateInit.copyWith(
          detailState: RequestState.Loaded,
          movieDetail: tMovieDetail,
          recommendationsState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit MovieDetailError when Get Movie Detail Failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        movieDetailStateInit.copyWith(detailState: RequestState.Loading),
        movieDetailStateInit.copyWith(
            detailState: RequestState.Error, message: 'Failed'),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('AddToWatchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
      build: () {
        when(mockSaveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const AddMovieWatchlist(tMovieDetail)),
      expect: () => [
        movieDetailStateInit.copyWith(message: 'Added to Watchlist'),
        movieDetailStateInit.copyWith(
            message: 'Added to Watchlist', isAddedtoWatchlist: true),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tMovieDetail));
        verify(mockGetWatchlistStatus.execute(tMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockSaveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const AddMovieWatchlist(tMovieDetail)),
      expect: () => [
        movieDetailStateInit.copyWith(message: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tMovieDetail));
        verify(mockGetWatchlistStatus.execute(tMovieDetail.id));
      },
    );
  });

  group('RemoveFromWatchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const RemoveMovieWatchlist(tMovieDetail)),
      expect: () => [
        movieDetailStateInit.copyWith(message: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tMovieDetail));
        verify(mockGetWatchlistStatus.execute(tMovieDetail.id));
      },
    );
  });

  group('LoadWatchlistStatus', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should Emit AddWatchlistStatus True',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const StatusMovieWatchlist(tId)),
      expect: () => [
        movieDetailStateInit.copyWith(isAddedtoWatchlist: true),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tMovieDetail.id));
      },
    );
  });
}
