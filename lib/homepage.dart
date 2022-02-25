import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_frog/main.dart';
import 'package:notes_app_frog/main/bloc.dart';
import 'package:notes_app_frog/searchpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage())),
                  icon: Icon(Icons.search)),
              IconButton(
                  icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode),
                  onPressed: () {
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                  })
            ],
          )
        ],
      ),
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
                        selectedTileColor: Colors.blueAccent,
                        // trailing: Text(note.createdAt),
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
