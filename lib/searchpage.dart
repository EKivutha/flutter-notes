import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:notes_app_frog/api/api.dart';

import 'api/models/note.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TypeAheadField<Note?>(
            hideSuggestionsOnKeyboardHide: false,
            // textFieldConfiguration: const TextFieldConfiguration(
            //   decoration: InputDecoration(
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(),
            //     hintText: 'Search Username',
            //   ),
            // ),
            suggestionsCallback: ApiClient.get,
            itemBuilder: (context, Note? suggestion) {
              final note = suggestion!;

              return ListTile(
                title: Text(note.subject!),
              );
            },
            noItemsFoundBuilder: (context) => const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'No Users Found.',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            onSuggestionSelected: (Note? suggestion) {
              final note = suggestion!;

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('Selected user: ${note.note}'),
                ));
            },
          ),
        ),
      )),
    );
  }
}
