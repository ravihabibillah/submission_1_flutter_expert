import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/now_playing/bloc/now_playing_bloc.dart';
import 'package:core/presentation/pages/on_the_air_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingBloc extends MockBloc<NowPlayingEvent, NowPlayingState>
    implements NowPlayingBloc {}

class NowPlayingEventFake extends Fake implements NowPlayingEvent {}

class NowPlayingStateFake extends Fake implements NowPlayingState {}

void main() {
  late MockNowPlayingBloc mockNowPlayingBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingEventFake());
    registerFallbackValue(NowPlayingStateFake());
  });
  setUp(() {
    mockNowPlayingBloc = MockNowPlayingBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingBloc>.value(
      value: mockNowPlayingBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(
      () => mockNowPlayingBloc.state,
    ).thenReturn(NowPlayingLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingBloc.state).thenReturn(TvOnTheAirHasData(tTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingBloc.state)
        .thenReturn(const NowPlayingError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
