import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api/api_client.dart';
import '../api/models/note.dart';

part 'event.dart';
part 'state.dart';

class NBloc extends Bloc<Event, NState> {
  NBloc({required ApiClient nApiClient})
      : _nApiClient = nApiClient,
        super(LoadInProgress()) {
    on<FetchStarted>(_onFetchStarted);
  }

  final ApiClient _nApiClient;

  void _onFetchStarted(
    FetchStarted event,
    Emitter<NState> emit,
  ) async {
    emit(LoadInProgress());
    try {
      final notes = await ApiClient.get as List;
      emit(LoadSuccess(notes));
    } catch (_) {
      emit(LoadFailure());
    }
  }
}
