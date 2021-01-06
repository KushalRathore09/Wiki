

import 'package:fl_wiki/ui/home/entity/pages.dart';
import 'package:fl_wiki/ui/home/entity/redirects.dart';

class Query {
  List<Pages> pages;
  List<Redirects> redirects;

  Query({this.pages, this.redirects});

  Query.fromJson(Map<String, dynamic> json) {
    if (json['redirects'] != null) {
      redirects = new List<Redirects>();
      json['redirects'].forEach((v) {
        redirects.add(new Redirects.fromJson(v));
      });
    }

    if (json['query']['pages'] != null) {
      pages = new List<Pages>();
      json['query']['pages'].forEach((v) {
        pages.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.redirects != null) {
      data['redirects'] = this.redirects.map((v) => v.toJson()).toList();
    }
    if (this.pages != null) {
      data['pages'] = this.pages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
