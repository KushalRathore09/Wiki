import 'package:fl_wiki/ui/base/base_bloc.dart';
import 'package:fl_wiki/ui/home/repo/home_repo.dart';
import 'package:fl_wiki/ui/home/state/home_state.dart';
import 'package:rxdart/rxdart.dart';


class HomeBloc extends BaseBloc {
  HomeRepo _homeRepo = HomeRepo();
   final listDataState = BehaviorSubject<ListDataState>();


  void getData({String query=''}) {
    subscription.add(_homeRepo
        .getPagesData(query)
        .map((data) => ListDataState.completed(data))
        .onErrorReturnWith(
            (error) => ListDataState.error(error))
        .startWith(ListDataState.loading())
        .listen((state) {
      print('////// State: $state');

      listDataState.add(state);
    }));
  }

  @override
  void dispose() {
    super.dispose();
    listDataState?.close();
  }

}