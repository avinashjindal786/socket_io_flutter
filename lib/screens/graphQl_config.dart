import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  static HttpLink httpLink = HttpLink("https://countries.trevorblades.com/");

  GraphQLClient client() => GraphQLClient(link: httpLink, cache: GraphQLCache());
}
