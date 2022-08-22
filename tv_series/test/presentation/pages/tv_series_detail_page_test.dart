import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';

class TvSeriesDetailEventFake extends Fake implements TvSeriesDetailEvent {}

class TvSeriesDetailStateFake extends Fake implements TvSeriesDetailState {}

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

void main() {
  late MockTvSeriesDetailBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TvSeriesDetailEventFake());
    registerFallbackValue(TvSeriesDetailStateFake());
  });

  setUp(() {
    mockBloc = MockTvSeriesDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvSeriesDetailState.initial().copyWith(
      detailState: RequestState.Loaded,
      tvSeriesDetail: testTvSeriesDetail,
      recommendationsState: RequestState.Loaded,
      tvSeriesRecommendations: [testTvSeries],
      isAddedtoWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(TvSeriesDetailState.initial().copyWith(
      detailState: RequestState.Loaded,
      tvSeriesDetail: testTvSeriesDetail,
      recommendationsState: RequestState.Loaded,
      tvSeriesRecommendations: [testTvSeries],
      isAddedtoWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   whenListen(
  //     mockBloc,
  //     Stream.fromIterable([
  //       TvSeriesDetailState.initial().copyWith(
  //         detailState: RequestState.Loaded,
  //         tvSeriesDetail: testTvSeriesDetail,
  //         recommendationsState: RequestState.Loaded,
  //         tvSeriesRecommendations: [testTvSeries],
  //         isAddedtoWatchlist: false,
  //       ),
  //       TvSeriesDetailState.initial().copyWith(
  //         detailState: RequestState.Loaded,
  //         tvSeriesDetail: testTvSeriesDetail,
  //         recommendationsState: RequestState.Loaded,
  //         tvSeriesRecommendations: [testTvSeries],
  //         isAddedtoWatchlist: true,
  //         message: 'Added to watchlist',
  //       ),
  //     ]),
  //     initialState: TvSeriesDetailState.initial(),
  //   );

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

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
  //         TvSeriesDetailState.initial().copyWith(
  //           detailState: RequestState.Loaded,
  //           tvSeriesDetail: testTvSeriesDetail,
  //           recommendationsState: RequestState.Loaded,
  //           tvSeriesRecommendations: [testTvSeries],
  //           isAddedtoWatchlist: false,
  //         ),
  //         TvSeriesDetailState.initial().copyWith(
  //           detailState: RequestState.Loaded,
  //           tvSeriesDetail: testTvSeriesDetail,
  //           recommendationsState: RequestState.Loaded,
  //           tvSeriesRecommendations: [testTvSeries],
  //           isAddedtoWatchlist: false,
  //           message: 'Failed',
  //         ),
  //       ]),
  //       initialState: TvSeriesDetailState.initial());

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
