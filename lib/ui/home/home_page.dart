import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_wiki/network/app_exception.dart';
import 'package:fl_wiki/network/rest_constants.dart';
import 'package:fl_wiki/ui/base/base_stateful_widget.dart';
import 'package:fl_wiki/ui/home/bloc/home_bloc.dart';
import 'package:fl_wiki/ui/home/state/home_state.dart';
import 'package:fl_wiki/utils/app_images.dart';
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
        body: isApiCall
            ? StreamBuilder<ListDataState>(
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
                })
            : Container(
                child: Center(
                  child: Stack(
                    children: [
                      Image.asset(wiki,fit: BoxFit.fill,),
                    ],
                  ),
                ),
              ));
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
      height: MediaQuery.of(context).size.height,
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
    final isImageBroken = page?.thumbnail?.source != "null"
        ? page?.thumbnail?.source
        : page?.thumbnail?.source;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => CustomWebView(
                      selectedUrl:
                          RestConstants.OPEN_WEBPAGE + page.title ?? "",
                    )));
      },
      child: Container(
        child: Card(
            elevation: 10.0,
            color: colorGrayscale10,
            child: new Stack(
              children: <Widget>[
                CachedNetworkImage(
                  height: 200.0,
                  fit: BoxFit.fitWidth,
                  imageUrl: page?.thumbnail?.source ?? "",
                  // here image is getting broken ..
                  /*imageUrl: "${RestConstants.IMAGE_URL}$isImageBroken",*/
                  placeholder: (context, url) => Skeleton(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                  ),
                  errorWidget: (context, url, error) => Container(
                      color: colorGrayscale10,
                      height: 200.0,
                      child: Center(
                          child: Icon(
                        Icons.error,
                        color: colorMinionYellow,
                        size: 40.0,
                      ))),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        page.title ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                blurRadius: 12.0,
                                color: colorBlack,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                      page?.terms == null ? Text("") : Text(
                        page?.terms?.description[0] ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                blurRadius: 12.0,
                                color: colorBlack,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                            fontWeight: FontWeight.bold),
                      ) ,
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
