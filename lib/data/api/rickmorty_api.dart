import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rickmorty/core/constants.dart';
import 'package:rickmorty/data/environments.dart';
import 'package:rickmorty/data/response/episodes_response.dart';
import 'package:rickmorty/data/response/error_response.dart';
import 'package:rickmorty/data/response/characters_response.dart';

class RickMortyApi {
  Future<Either<ErrorResponse, CharactersResponse>> getCharacters(
      String? name, String? gender, String? status, int? page) async {
    try {
      if (gender == 'All') gender = '';
      if (status == 'All') status = '';
      final response = await http.get(
          Uri.parse(
              '${Environments.apiUrl}/character/?name=${name?.toLowerCase() ?? ''}&gender=${gender?.toLowerCase() ?? ''}&status=${status?.toLowerCase() ?? ''}&page=${page??1}'),
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(charactersResponseFromJson(response.body).info?.next);
        return Right(charactersResponseFromJson(response.body));
      } else {
        return Left(errorResponseFromJson(response.body));
      }
    } catch (e) {
      return Left(ErrorResponse(error: UNKNOW_ERROR));
    }
  }

  Future<Either<ErrorResponse, List<EpisodeResponse>>> getEpisodesByIds(
      String episodes) async {
    try {
      final response = await http.get(
          Uri.parse('${Environments.apiUrl}/episode/$episodes,0'),
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(episodesResponseFromJson(response.body));
      } else {
        return Left(errorResponseFromJson(response.body));
      }
    } catch (e) {
      return Left(ErrorResponse(error: UNKNOW_ERROR));
    }
  }
}
