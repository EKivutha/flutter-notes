import 'dart:convert';

import 'package:notes_app_frog/api/api.dart';
import 'package:notes_app_frog/api/queries/queries.dart' as queries;
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

class GetRequestFailure implements Exception {}

class ApiClient {
  const ApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;
  factory ApiClient.create() {
    final httpLink =
        HttpLink('https://6218858d1a1ba20cbaa33263.mockapi.io/notes/');
    final link = Link.from([httpLink]);
    return ApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  final GraphQLClient _graphQLClient;

  Future<List<Note>> get() async {
    var url = 'https://6218858d1a1ba20cbaa33263.mockapi.io/notes/';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    // print(response.body);
    final data = json.decode(response.body) as List;
    // print(data);
    return data.map((e) => Note.fromJson(e)).toList();

    // final result = await _graphQLClient.query(
    //   QueryOptions(document: gql(queries.get)),
    // );
    // if (result.hasException) throw GetRequestFailure();
    // final data = result.data?[''] as List;
    // return data.map((e) => Note.fromJson(e)).toList();
  }
}
