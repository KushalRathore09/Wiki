import 'package:fl_wiki/network/view_state.dart';
import 'package:fl_wiki/ui/base/base_bloc.dart';
import 'package:fl_wiki/ui/home/entity/pages.dart';
import 'package:fl_wiki/ui/home/entity/query.dart';
import 'package:fl_wiki/ui/home/repo/home_repo.dart';
import 'package:fl_wiki/ui/home/state/home_state.dart';
import 'package:rxdart/rxdart.dart';


class HomeBloc extends BaseBloc {
  HomeRepo _homeRepo = HomeRepo();
  final viewState = PublishSubject<ViewState>();
  final listDataState = BehaviorSubject<ListDataState>();

  final querryListData = BehaviorSubject<Query>();
  final pagesListData = BehaviorSubject<List<Pages>>();

  void getData({int page = 1, bool clear = false, String query=''}) {
    subscription.add(_homeRepo
        .getPagesData(page,query)
        .map((data) => ListDataState.completed(data, isLoadingMore: page > 1))
        .onErrorReturnWith(
            (error) => ListDataState.error(error, isLoadingMore: page > 1))
        .startWith(ListDataState.loading(isLoadingMore: page > 1))
        .listen((state) {
      print('////// State: $state');

      listDataState.add(state);
      if(state.isCompleted()){
        final newList = state.data.pages ?? List();
        final currentList = querryListData.value?.pages ?? List();
        final data = state.data;

        if(state.data.pages == 1){
          if(clear == false){
            currentList.clear();
          }
        }
        currentList.addAll(newList);

        List<Pages>pagesItems = [];

        for (var i = 0; i < (state.data.pages).length; i ++ ) {
          pagesItems.add(
              new Pages(
                  title: state.data.pages[i].title,
                  terms: state.data.pages[i].terms,
                thumbnail: state.data.pages[i].thumbnail
              )
          );
        }

        querryListData.add(data);
        pagesListData.add(pagesItems);

      }

    }));
  }

  void loadMore(String query) {
    if(querryListData.value?.pages==querryListData.value?.pages){
      getData(page: (1), clear: (true), query: (query));
    }
    else{
      getData(page: (querryListData.value?.pages ?? 1) , query: (query));
    }
  }

  @override
  void dispose() {
    super.dispose();
    viewState?.close();
  }

}