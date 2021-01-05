


import 'package:fl_wiki/ui/home/entity/terms.dart';
import 'package:fl_wiki/ui/home/entity/thumbnail.dart';

class Pages {
  int pageid;
  int ns;
  String title;
  int index;
  Thumbnail thumbnail;
  Terms terms;

  Pages(
      {this.pageid,
        this.ns,
        this.title,
        this.index,
        this.thumbnail,
        this.terms});

  Pages.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'];
    ns = json['ns'];
    title = json['title'];
    index = json['index'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    terms = json['terms'] != null ? new Terms.fromJson(json['terms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageid'] = this.pageid;
    data['ns'] = this.ns;
    data['title'] = this.title;
    data['index'] = this.index;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.terms != null) {
      data['terms'] = this.terms.toJson();
    }
    return data;
  }
}