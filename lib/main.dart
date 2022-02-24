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
      appBar: AppBar(title: Text('Notes')),
      body: Center(
        child: BlocBuilder<Bloc, nState>(
          builder: (context, state) {
            if (state is LoadInProgress) {
              return CircularProgressIndicator();
            }
            if (state is LoadSuccess) {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final job = state.notes[index];
                  return ListTile(
                    key: Key(job.id),
                    leading: Icon(Icons.location_city),
                    title: Text(job.title),
                    trailing: Icon(
                      job.isFeatured == true ? Icons.star : Icons.star_border,
                      color: Colors.orangeAccent,
                    ),
                    subtitle: job.locationNames != null
                        ? Text(job.locationNames!)
                        : null,
                  );
                },
              );
            }
            return const Text('Oops something went wrong!');
          },
        ),
      ),
    );
  }
}
