// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_object_tv.dart';

class PopularTvSeriesEventFake extends Fake implements TvSeriesPopularEvent {}

class PopularTvSeriesStateFake extends Fake implements TvSeriesPopularState {}

class MockPopularTvSeriesBloc extends MockBloc<TvSeriesPopularEvent, TvSeriesPopularState>
  implements TvSeriesPopularBloc {}

void main() {
  late MockPopularTvSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvSeriesEventFake());
    registerFallbackValue(PopularTvSeriesStateFake());
  });

  setUp(() {
    mockBloc = MockPopularTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesPopularBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvSeriesPopularLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvSeriesPopularHasData([testTvSeries]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(const TvSeriesPopularError(('error_message')));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Empty',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(TvSeriesPopularEmpty());

        final textFinder = find.text('TV Series Popular is empty');

        await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

        expect(textFinder, findsOneWidget);
      });
}
