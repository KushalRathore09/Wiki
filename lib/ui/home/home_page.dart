import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_wiki/network/app_exception.dart';
import 'package:fl_wiki/network/rest_constants.dart';
import 'package:fl_wiki/ui/base/base_stateful_widget.dart';
import 'package:fl_wiki/ui/home/bloc/home_bloc.dart';
import 'package:fl_wiki/ui/home/state/home_state.dart';
import 'package:fl_wiki/widgets/custom_loader.dart';
import 'package:fl_wiki/widgets/custom_webview.dart';
import 'package:fl_wiki/widgets/error_view.dart';
import 'package:fl_wiki/widgets/skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import 'entity/pages.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends BaseStatefulWidgetState<HomePage> {
  final _homeBloc = HomeBloc();
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text(
    "Wiki",
    style: new TextStyle(color: Colors.white),
  );
  final TextEditingController _searchQuery = new TextEditingController();

  bool isApiCall = false;

  HomePageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isNotEmpty) {
        _homeBloc.getData(query: _searchQuery.text);
        setState(() {
          isApiCall = true;
        });
      } else {
        setState(() {
          isApiCall = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildBar(context),
        body: isApiCall ? StreamBuilder<ListDataState>(
            stream: _homeBloc.listDataState,
            initialData: _homeBloc.listDataState.value,
            builder: (context, snapshot) {
              final state = snapshot.data;

              if (state?.isLoading() ?? true) {
                return CustomLoader();
              }

              if (state.isError()) {
                return Center(
                  child: ErrorView(
                    content: state.error?.toString(),
                    retryVisible: (state.error is NoInternetException),
                    onPressed: () {
                      _homeBloc.getData();
                    },
                  ),
                );
              }

              final items = state.data?.pages ?? List();

              return _wikiList(items);
            }) : Container() );
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                autofocus: true,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Find here...",
                    hintStyle: new TextStyle(
                        color: colorBlackGradient90, fontSize: 20.0)),
              );
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle =
          new Text("Wiki", style: new TextStyle(color: Colors.white));
      _searchQuery.clear();
    });
  }

  Widget _wikiList(List<Pages> pagesList) {
    return Container(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Pages page = pagesList[index];
          return _listTile(page);
        },
        itemCount: pagesList.length,
      ),
    );
  }

  _listTile(Pages page) {
    final isImageBroken = page.thumbnail.source != "null"
        ? page.thumbnail.source
        : page.thumbnail.source;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => CustomWebView(
                      selectedUrl:
                          RestConstants.OPEN_WEBPAGE + _searchQuery.text,
                    )));
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: "${RestConstants.IMAGE_URL}$isImageBroken",
            placeholder: (context, url) => Skeleton(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
            ),
            errorWidget: (context, url, error) => Container(
                color: colorGrayscale10,
                height: 40.0,
                child: Center(
                    child: Icon(
                  Icons.error,
                  color: colorMinionYellow,
                  size: 40.0,
                ))),
          ),
          title: Text(
            page.title ?? "",
            style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
          ),
          subtitle: Text(
            page.terms.description ?? "",
            maxLines: 3,
            style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}
