// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickmorty/core/constants.dart';
import 'package:rickmorty/domain/models/character.dart';
import 'package:rickmorty/domain/usecases/get_characters.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUseCase? _getCharactersUseCase;

  CharactersBloc(this._getCharactersUseCase) : super(InitialState()) {
    on<GetCharactersEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final gender = genderValues.entries
            .firstWhere((e) => e.value == (event.gender ?? Gender.all))
            .key;
        final status = statusValues.entries
            .firstWhere((e) => e.value == (event.status ?? Status.all))
            .key;
        var response =
            await _getCharactersUseCase?.execute(event.name, gender, status, event.page??1);
        response?.fold((error) {
          emit(ErrorState(error));
        }, (characters) {
          emit(SuccessfulState(characters));
        });
      } catch (e) {
        emit(const ErrorState(UNKNOW_ERROR));
      }
    });
  }
}
