import 'package:fl_wiki/ui/home/ds/home_ds.dart';
import 'package:fl_wiki/ui/home/entity/query.dart';


class HomeRepo {
  final _homeDs = HomeApiDS();

  Stream<Query> getPagesData(String query) {
    return _homeDs.getPagesData(query);
  }
}
