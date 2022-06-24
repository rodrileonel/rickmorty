part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class GetCharactersEvent extends CharactersEvent {
  final Gender? gender;
  final String? name;
  final Status? status;
  final int? page;
  const GetCharactersEvent({this.gender, this.name, this.status, this.page});
}
