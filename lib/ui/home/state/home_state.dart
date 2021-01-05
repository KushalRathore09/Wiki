import 'package:fl_wiki/ui/base/base_ui_state.dart';
import 'package:fl_wiki/ui/home/entity/query.dart';


class ListDataState extends BaseUiState<Query> {
  var isLoadingMore = false;

  ListDataState();

  /// Loading state
  ListDataState.loading({this.isLoadingMore}) : super.loading();

  /// Completed state
  ListDataState.completed(Query query,{this.isLoadingMore}) : super.completed(data: query);

  /// Error state
  ListDataState.error(dynamic exception,{this.isLoadingMore}) : super.error(exception);
}