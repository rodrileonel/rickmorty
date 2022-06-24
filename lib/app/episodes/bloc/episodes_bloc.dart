// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:rickmorty/core/constants.dart';
import 'package:rickmorty/domain/models/episode.dart';
import 'package:rickmorty/domain/usecases/get_episodes.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final GetEpisodesUseCase? _getEpisodesUseCase;

  EpisodesBloc(this._getEpisodesUseCase) : super(InitialState()) {
    on<GetEpisodesEvent>((event, emit) async {
      emit(LoadingState());
      try {
        var response = await _getEpisodesUseCase?.execute(event.episodes ?? '');
        response?.fold((error) {
          emit(ErrorState(error));
        }, (episodes) {
          emit(SuccessfulState(episodes));
        });
      } catch (e) {
        emit(const ErrorState(UNKNOW_ERROR));
      }
    });
  }
}
