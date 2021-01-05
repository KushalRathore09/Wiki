import 'package:fl_wiki/ui/home/ds/home_ds.dart';
import 'package:fl_wiki/ui/home/entity/query.dart';


class HomeRepo {
  final _homeDs = HomeApiDS();

  Stream<Query> getPagesData(int page, String query) {
    return _homeDs.getPagesData(page, query);
  }
}
