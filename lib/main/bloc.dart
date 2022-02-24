import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api/api_client.dart';
import '../api/models/note.dart';

part 'event.dart';
part 'state.dart';

class NBloc extends Bloc<Event, nState> {
  NBloc({required ApiClient nApiClient})
      : _nApiClient = nApiClient,
        super(LoadInProgress()) {
    on<FetchStarted>(_onFetchStarted);
  }

  final ApiClient _nApiClient;

  void _onFetchStarted(
    FetchStarted event,
    Emitter<State> emit,
  ) async {
    emit(LoadInProgress());
    try {
      final jobs = await _nApiClient.getJobs();
      emit(LoadSuccess(jobs));
    } catch (_) {
      emit(LoadFailure());
    }
  }
}
