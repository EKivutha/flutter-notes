part of 'bloc.dart';

@immutable
abstract class NState {}

class LoadInProgress extends NState {}

class LoadSuccess extends NState {
  LoadSuccess(this.notes);

  final List<dynamic> notes;
}

class LoadFailure extends NState {}
