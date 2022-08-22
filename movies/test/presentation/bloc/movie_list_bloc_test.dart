import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;
  late MoviePopularBloc moviePopularBloc;
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(mockGetNowPlayingMovies);
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
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
  final tMovieList = <Movie>[tMovie];
  
  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(movieListBloc.state, MovieListEmpty());
    });

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(LoadMovieList()),
      expect: () => [
        MovieListLoading(),
        MovieListHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(LoadMovieList()),
      expect: () => [
        MovieListLoading(),
        MovieListError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('popular movies', () {
    test('initialState should be Empty', () {
      expect(moviePopularBloc.state, MoviePopularEmpty());
    });

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(LoadMoviePopular()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(LoadMoviePopular()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('top rated movies', () {
    test('initialState should be Empty', () {
      expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(LoadMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        MovieTopRatedHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, Error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(LoadMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        MovieTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
