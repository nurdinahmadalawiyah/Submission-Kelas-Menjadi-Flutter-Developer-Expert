import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularBloc moviePopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

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

  final tMovieList = <Movie>[tMovie];

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
    'Should emit [Loading, Empty] when data is gotten unsuccessfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right(<Movie>[]));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(LoadMoviePopular()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularHasData(<Movie>[]),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    }
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(LoadMoviePopular()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    }
  );
}