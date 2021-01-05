import 'package:fl_wiki/ui/base/base_ui_state.dart';
import 'package:fl_wiki/ui/home/entity/query.dart';


class ListDataState extends BaseUiState<Query> {

  ListDataState();

  /// Loading state
  ListDataState.loading() : super.loading();

  /// Completed state
  ListDataState.completed(Query query) : super.completed(data: query);

  /// Error state
  ListDataState.error(dynamic exception) : super.error(exception);
}