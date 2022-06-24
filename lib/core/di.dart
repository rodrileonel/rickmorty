import 'package:get_it/get_it.dart';
import 'package:rickmorty/app/characters/bloc/characters_bloc.dart';
import 'package:rickmorty/app/episodes/bloc/episodes_bloc.dart';
import 'package:rickmorty/data/repository/rickmorty_repository.dart';
import 'package:rickmorty/domain/usecases/get_characters.dart';
import 'package:rickmorty/domain/usecases/get_episodes.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerFactory(() => CharactersBloc(getIt()));
  getIt.registerFactory(() => EpisodesBloc(getIt()));

  getIt.registerLazySingleton(() => GetCharactersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetEpisodesUseCase(getIt()));

  getIt.registerLazySingleton<RickMortyRepository>(
      () => RickMortyRepositoryNetwork());
}
