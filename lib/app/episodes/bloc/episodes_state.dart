part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesState extends Equatable {
  const EpisodesState();

  @override
  List<Object> get props => [];
}

class InitialState extends EpisodesState {}

class LoadingState extends EpisodesState {}

class SuccessfulState extends EpisodesState {
  final List<Episode> episodes;
  const SuccessfulState(this.episodes);
}

class ErrorState extends EpisodesState {
  final String message;
  const ErrorState(this.message);
}
