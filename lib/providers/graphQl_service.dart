import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/countries_model.dart';
import '../screens/graphQl_config.dart';
import 'constant.dart';

class GraphQlService {
  static GraphQlConfig config = GraphQlConfig();
  GraphQLClient client = config.client();

  Future<GraphQLResponseModel> getContinent() async {
    QueryResult result = await client.query(QueryOptions(variables: {"code": "AF"}, fetchPolicy: FetchPolicy.noCache, document: gql(""" 
      query Query(\$code: ID!){
        continents {
          name
          code
    
        }
        continent(code: \$code) {
          code
          countries {
            currencies
          }
        }
      }
      """)));

    // _checkGraphQLResponse(data: result.data, methodName: "getContinent");
    log(result.data!["continents"].toString());

    return GraphQLResponseModel(data: result.data?["continents"]);
  }

  void _checkGraphQLResponse({required data, required methodName}) {
    // print(data[methodName]);
    if (data[methodName]['status'] == STATUS_CODE_400 || data[methodName]['status'] == STATUS_CODE_401) {
      log(methodName);
    }
  }
}
