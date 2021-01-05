
import 'package:dio/dio.dart';
import 'package:fl_wiki/network/client/api_client.dart';
import 'package:fl_wiki/network/rest_constants.dart';
import 'package:fl_wiki/ui/home/entity/pages.dart';
import 'package:fl_wiki/ui/home/entity/query.dart';

class HomeApiDS {

  Stream<Query> getPagesData(String query) {
    String url = "";

    if (query.isNotEmpty) {
      url = RestConstants.BASE_URL+query;
    }
    return ApiClient()
        .dio()
        .get(url, options: Options(headers: {ApiClient.REQUIRES_HEADER: false}))
        .asStream()
        .map((response) => Query.fromJson(response.data));
  }
}
