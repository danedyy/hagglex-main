import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class GraphQLClientConc extends GraphQLClient {
  final HttpLink httpLink;
  final AuthLink authLink;

  GraphQLClientConc({
    @required this.httpLink,
    @required this.authLink,
  }) : super(
          cache: GraphQLCache(
            store: HiveStore(),
          ),
          link: authLink.concat(httpLink),
        );

  GraphQLClientConc copyWith({
    HttpLink httpLink,
    AuthLink authLink,
  }) {
    return GraphQLClientConc(
      httpLink: httpLink ?? this.httpLink,
      authLink: authLink ?? this.authLink,
    );
  }
}
