import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';

class TopRatedMoviesEventFake extends Fake implements MovieTopRatedEvent {}

class TopRatedMoviesStateFake extends Fake implements MovieTopRatedState {}

class MockTopRatedMoviesBloc extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

void main() {
  late MockTopRatedMoviesBloc mockbloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMoviesEventFake());
    registerFallbackValue(TopRatedMoviesStateFake());
  });

  setUp(() {
    mockbloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>.value(
      value: mockbloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockbloc.state).thenReturn(MovieTopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockbloc.state).thenReturn(MovieTopRatedHasData([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockbloc.state).thenReturn(MovieTopRatedEmpty());

    final textFinder = find.text('Movie Top Rated is empty');

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
