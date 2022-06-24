import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickmorty/app/characters/bloc/characters_bloc.dart';
import 'package:rickmorty/app/characters/pages/characters_list_page.dart';
import 'package:rickmorty/core/di.dart' as di;

class MockCharactersBloc extends MockBloc<CharactersEvent, CharactersState>
    implements CharactersBloc {}

void main() {
  late MockCharactersBloc? bloc;

  setUpAll(() {
    di.init();
    bloc = MockCharactersBloc();
  });

  testWidgets('Render listpage correctly', (WidgetTester tester) async {
    when(() => bloc?.state).thenReturn(const SuccessfulState([]));

    await tester.pumpWidget(
      BlocProvider<CharactersBloc>(
        create: (context) => bloc!,
        child: const MaterialApp(
          title: 'Widget Test',
          home: Scaffold(body: CharactersListPage()),
        ),
      ),
    );
    expect(find.byKey(const Key('character-list-filter')), findsOneWidget);
    expect(
        find.byKey(const Key('character-list-gender-button')), findsOneWidget);
    expect(
        find.byKey(const Key('character-list-status-button')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('character-list')), findsOneWidget);
  });

  testWidgets('Render listpage empty', (WidgetTester tester) async {
    when(() => bloc?.state).thenReturn(const ErrorState(''));

    await tester.pumpWidget(
      BlocProvider<CharactersBloc>(
        create: (context) => bloc!,
        child: const MaterialApp(
          title: 'Widget Test',
          home: Scaffold(body: CharactersListPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('character-list-empty')), findsOneWidget);
  });
}
