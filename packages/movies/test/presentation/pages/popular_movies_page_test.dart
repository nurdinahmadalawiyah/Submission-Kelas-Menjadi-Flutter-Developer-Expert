// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import '../../dummy_data/dummy_objects.dart';

class PopularMoviesEventFake extends Fake implements MoviePopularEvent {}

class PopularMoviesStateFake extends Fake implements MoviePopularState {}

class MockPopularMoviesBloc extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}
void main() {
  late MockPopularMoviesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(PopularMoviesEventFake());
    registerFallbackValue(PopularMoviesStateFake());
  });

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MoviePopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MoviePopularHasData([testMovie]));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockBloc.state).thenReturn(const MoviePopularError(('error_message')));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MoviePopularEmpty());

    final textFinder = find.text('Movie Popular is empty');

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
