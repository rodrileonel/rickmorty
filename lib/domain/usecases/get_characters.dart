import 'package:dartz/dartz.dart';
import 'package:rickmorty/data/repository/rickmorty_repository.dart';
import 'package:rickmorty/domain/models/character.dart';

class GetCharactersUseCase {
  final RickMortyRepository? _rickMortyRepository;

  GetCharactersUseCase(this._rickMortyRepository);

  Future<Either<String, List<Character>>> execute(
      String? name, String? gender, String? status, int? page) async {
    return await _rickMortyRepository!.getCharacters(name, gender, status, page);
  }
}
