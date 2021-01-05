/*class RestConstants {
  static const String BASE_URL = 'https://api.themoviedb.org/3/';
  static const String IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
  static const String NOW_PLAYING = 'movie/now_playing?api_key=';
  static const String SEARCH = 'search/movie?api_key=';
  static const String ApiKey = 'c0d0079aeb23d94e4a8600551a022a77';
  static const String Language = 'language=en-US&page=';
  static const String adult = '&include_adult=false';
  static const String query = '&query=';
  static const String GET_NOW_PLAYING_URL = '$NOW_PLAYING$ApiKey&$Language';
  static const String GET_SEARCH_URL = '$SEARCH$ApiKey&$Language';
}*/

class RestConstants {
  static const String BASE_URL =
      'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=';
  static const String IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
  static const String SEARCH = 'search/movie?api_key=';
  static const String query = '&gpssearch=';
  static const String OPEN_WEBPAGE = 'https://en.wikipedia.org/wiki/';
}
