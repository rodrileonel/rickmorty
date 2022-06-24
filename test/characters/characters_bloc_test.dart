import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickmorty/app/characters/bloc/characters_bloc.dart';
import 'package:rickmorty/domain/models/character.dart';
import 'package:rickmorty/domain/usecases/get_characters.dart';
import 'package:rickmorty/core/di.dart' as di;

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

void main() {
  late MockGetCharactersUseCase? mockGetUser;
  late CharactersBloc? usersBloc;

  setUpAll(() {
    di.init();
    mockGetUser = MockGetCharactersUseCase();
    usersBloc = CharactersBloc(mockGetUser);
  });

  tearDown(() {
    usersBloc?.close();
  });

  test('should initial state equals to InitialState', () async {
    expect(usersBloc?.state, equals(InitialState()));
  });

  blocTest<CharactersBloc, CharactersState>(
    'emits Loading and SuccessfulState',
    build: () {
      when(() => mockGetUser?.execute('', 'All', 'All',0))
          .thenAnswer((any) async => const Right([]));
      return CharactersBloc(mockGetUser);
    },
    act: (bloc) => bloc.add(const GetCharactersEvent(
        gender: Gender.all, name: '', status: Status.all)),
    expect: () => [LoadingState(), const SuccessfulState([])],
  );

  blocTest<CharactersBloc, CharactersState>(
    'emits Loading and ErrorState',
    build: () {
      when(() => mockGetUser?.execute('', 'All', 'All',0))
          .thenAnswer((any) async => const Left(''));
      return CharactersBloc(mockGetUser);
    },
    act: (bloc) => bloc.add(const GetCharactersEvent(
        gender: Gender.all, name: '', status: Status.all)),
    expect: () => [LoadingState(), const ErrorState('')],
  );
}
