import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_frog/main/bloc.dart';

import 'api/models/note.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: BlocBuilder<NBloc, NState>(
        builder: (context, state) {
          if (state is LoadInProgress) {
            return const CircularProgressIndicator();
          }
          if (state is LoadSuccess) {
            final note = state.notes[int.parse(id)];
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(note.subject!),
                    Center(child: Text(note.note!)),
                  ],
                ),
              ),
            );
          }
          if (state is LoadFailure) {
            return Text("Load Data Failure $state");
          }
          return const Text('Oops something went wrong!');
        },
      ),
    );
  }
}
