part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesEvent extends Equatable {
  const EpisodesEvent();

  @override
  List<Object> get props => [];
}

class GetEpisodesEvent extends EpisodesEvent {
  final String? episodes;
  const GetEpisodesEvent({this.episodes});
}
