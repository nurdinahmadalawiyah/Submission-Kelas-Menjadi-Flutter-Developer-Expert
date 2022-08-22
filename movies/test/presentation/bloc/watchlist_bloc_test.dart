import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/watchlist_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBloc = WatchlistMoviesBloc(mockGetWatchlistMovies);
  });

  final tMovies = <Movie>[testMovie];

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [WatchlistLoading, WatchlistHasData] when data is gotten successfuly',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovies));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchlistMoviesData()),
    expect: () => [
      WatchlistLoading(),
      WatchlistHasData(tMovies),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [WatchlistLoading, WatchlistEmpty] when data is empty',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(<Movie>[]));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchlistMoviesData()),
    expect: () => [
      WatchlistLoading(),
      WatchlistHasData(<Movie>[]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [WatchlistLoading, WatchlistError] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchlistMoviesData()),
    expect: () => [
      WatchlistLoading(),
      WatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
