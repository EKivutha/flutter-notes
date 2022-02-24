import 'package:notes_app_frog/api/api.dart';
import 'package:notes_app_frog/api/queries/queries.dart' as queries;
import 'package:graphql/client.dart';

class GetRequestFailure implements Exception {}

class ApiClient {
  const ApiClient({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;
  factory ApiClient.create() {
    final httpLink = HttpLink('https://api.graphql.jobs');
    final link = Link.from([httpLink]);
    return ApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  final GraphQLClient _graphQLClient;

  Future<List<Note>> getJobs() async {
    final result = await _graphQLClient.query(
      QueryOptions(document: gql(queries.get)),
    );
    if (result.hasException) throw GetRequestFailure();
    final data = result.data?['jobs'] as List;
    return data.map((e) => Note.fromJson(e)).toList();
  }
}
