import 'package:dartz/dartz.dart';
import 'package:rickmorty/data/repository/rickmorty_repository.dart';
import 'package:rickmorty/domain/models/episode.dart';

class GetEpisodesUseCase {
  final RickMortyRepository? _rickMortyRepository;

  GetEpisodesUseCase(this._rickMortyRepository);

  Future<Either<String, List<Episode>>> execute(String episodes) async {
    return await _rickMortyRepository!.getEpisodesByIds(episodes);
  }
}
