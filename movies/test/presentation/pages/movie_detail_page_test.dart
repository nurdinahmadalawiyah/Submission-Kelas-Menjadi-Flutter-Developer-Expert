import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
  });

  setUp(() {
    mockBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      detailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      recommendationsState: RequestState.Loaded,
      movieRecommendations: [testMovie],
      isAddedtoWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      detailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      recommendationsState: RequestState.Loaded,
      movieRecommendations: [testMovie],
      isAddedtoWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   whenListen(
  //       mockBloc,
  //       Stream.fromIterable([
  //         MovieDetailState.initial().copyWith(
  //           detailState: RequestState.Loaded,
  //           movieDetail: testMovieDetail,
  //           recommendationsState: RequestState.Loaded,
  //           movieRecommendations: [testMovie],
  //           isAddedtoWatchlist: true,
  //         ),
  //         MovieDetailState.initial().copyWith(
  //           detailState: RequestState.Loaded,
  //           movieDetail: testMovieDetail,
  //           recommendationsState: RequestState.Loaded,
  //           movieRecommendations: [testMovie],
  //           isAddedtoWatchlist: true,
  //           message: 'Added to Watchlist',
  //         ),
  //       ]),
  //       initialState: MovieDetailState.initial());

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   whenListen(
  //       mockBloc,
  //       Stream.fromIterable([
  //         MovieDetailState.initial().copyWith(
  //           detailState: RequestState.Loaded,
  //           movieDetail: testMovieDetail,
  //           recommendationsState: RequestState.Loaded,
  //           movieRecommendations: [testMovie],
  //           isAddedtoWatchlist: false,
  //         ),
  //         MovieDetailState.initial().copyWith(
  //           detailState: RequestState.Loaded,
  //           movieDetail: testMovieDetail,
  //           recommendationsState: RequestState.Loaded,
  //           movieRecommendations: [testMovie],
  //           isAddedtoWatchlist: false,
  //           message: 'Failed',
  //         ),
  //       ]),
  //       initialState: MovieDetailState.initial());

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.check), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
