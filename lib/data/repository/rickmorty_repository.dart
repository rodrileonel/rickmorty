import 'package:dartz/dartz.dart';
import 'package:rickmorty/core/constants.dart';
import 'package:rickmorty/data/api/rickmorty_api.dart';
import 'package:rickmorty/data/response/characters_response.dart';
import 'package:rickmorty/data/response/episodes_response.dart';
import 'package:rickmorty/domain/models/character.dart';
import 'package:rickmorty/domain/models/episode.dart';

abstract class RickMortyRepository {
  Future<Either<String, List<Character>>> getCharacters(
      String? name, String? gender, String? status, int? page);
  Future<Either<String, List<Episode>>> getEpisodesByIds(String episodes);
}

class RickMortyRepositoryNetwork implements RickMortyRepository {
  final rickMortyApi = RickMortyApi();

  @override
  Future<Either<String, List<Character>>> getCharacters(
      String? name, String? gender, String? status, int? page) async {
    List<Character>? c = [];
    final char = await rickMortyApi.getCharacters(name, gender, status, page);
    return char.fold((error) {
      return Left(error.error ?? UNKNOW_ERROR);
    }, (characters) async {
      for (CharacterResponse character in characters.results ?? []) {
        c.add(Character(
            id: character.id,
            name: character.name,
            status: character.status,
            specie: character.species,
            gender: genderValues[character.gender],
            location: character.location?.name,
            image: character.image,
            type: character.type,
            origin: character.origin?.name,
            url: character.url,
            created: character.created,
            page: int.parse('${characters.info?.next?.split('=').last}'),
            episodes: character.episode
                ?.map((e) =>
                    e.split('https://rickandmortyapi.com/api/episode/').last)
                .toList()
                .join(',')));
      }
      return Right(c);
    });
  }

  @override
  Future<Either<String, List<Episode>>> getEpisodesByIds(
      String episodes) async {
    List<Episode>? e = [];
    final ep = await rickMortyApi.getEpisodesByIds(episodes);
    return ep.fold((error) {
      return Left(error.error ?? UNKNOW_ERROR);
    }, (episodes) async {
      for (EpisodeResponse episode in episodes) {
        e.add(Episode(
          id: episode.id,
          name: episode.name,
          airDate: episode.airDate,
          episode: episode.episode,
          characters: episode.characters,
          url: episode.url,
          created: episode.url,
        ));
      }
      return Right(e);
    });
  }
}
