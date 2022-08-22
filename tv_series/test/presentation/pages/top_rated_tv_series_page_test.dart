import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';

class TopRatedTvSeriesEventFake extends Fake implements TvSeriesTopRatedEvent {}

class TopRatedTvSeriesStateFake extends Fake implements TvSeriesTopRatedState {}

class MockTopRatedTvSeriesBloc extends MockBloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState>
    implements TvSeriesTopRatedBloc {}

void main() {
  late MockTopRatedTvSeriesBloc mockbloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTvSeriesEventFake());
    registerFallbackValue(TopRatedTvSeriesStateFake());
  });

  setUp(() {
    mockbloc = MockTopRatedTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesTopRatedBloc>.value(
      value: mockbloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockbloc.state).thenReturn(TvSeriesTopRatedLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => mockbloc.state).thenReturn(TvSeriesTopRatedHasData([testTvSeries]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Empty',
          (WidgetTester tester) async {
        when(() => mockbloc.state).thenReturn(TvSeriesTopRatedEmpty());

        final textFinder = find.text('TV Series Top Rated is empty');

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

        expect(textFinder, findsOneWidget);
      });
}
