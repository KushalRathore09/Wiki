import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_wiki/network/client/api_client.dart';
import 'package:fl_wiki/network/rest_constants.dart';
import 'package:fl_wiki/ui/home/entity/query.dart';


class HomeApiDS {
  /*Stream<NowPlaying> getMovieDataDs(int page, String query) {
    String url = '';
    if (query.isEmpty) {
      url = RestConstants.GET_NOW_PLAYING_URL + "${page.toString()}";
    } else {
      url = RestConstants.GET_SEARCH_URL +
          "${page.toString()}" +
          RestConstants.query +
          query;
    }
    return ApiClient()
        .dio()
        .get(url, options: Options(headers: {ApiClient.REQUIRES_HEADER: false}))
        .asStream()
        .map((response) => nowPlayingFromJson(response.data));
  }*/

  Stream<Query> getPagesData(int page, String query) {
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
