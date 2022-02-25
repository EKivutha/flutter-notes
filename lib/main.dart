import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_frog/api/api.dart';
import 'package:notes_app_frog/main/bloc.dart';

void main() => runApp(MyApp(nApiClient: ApiClient.create()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.nApiClient}) : super(key: key);
  final ApiClient nApiClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
            create: (_) => NBloc(
                  nApiClient: nApiClient,
                )..add(FetchStarted()),
            child: const HomePage()));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: Center(
        child: BlocBuilder<NBloc, NState>(
          builder: (context, state) {
            if (state is LoadInProgress) {
              return const CircularProgressIndicator();
            }
            if (state is LoadSuccess) {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return Center(
                    child: Card(
                      child: ListTile(
                        key: Key(note.id),
                        leading: const Icon(Icons.note),
                        title: Text(note.subject!),
                        trailing: Text(note.createdAt),
                        subtitle: Text(note.note!),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is LoadFailure) {
              return Text("Load Data Failure $state");
            }
            return const Text('Oops something went wrong!');
          },
        ),
      ),
    );
  }
}
