part of 'bloc.dart';

@immutable
abstract class nState {}

class LoadInProgress extends nState {}

class LoadSuccess extends nState {
  LoadSuccess(this.notes);

  final List<Note> notes;
}

class LoadFailure extends nState {}
