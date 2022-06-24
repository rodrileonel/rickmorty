part of 'characters_bloc.dart';

@immutable
abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class InitialState extends CharactersState {}

class LoadingState extends CharactersState {}

class SuccessfulState extends CharactersState {
  final List<Character> characters;
  const SuccessfulState(this.characters);
}

class ErrorState extends CharactersState {
  final String message;
  const ErrorState(this.message);
}
