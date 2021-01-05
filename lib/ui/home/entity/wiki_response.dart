



import 'package:fl_wiki/ui/home/entity/query.dart';

import 'continue.dart';

class WikiResponse {
  bool batchcomplete;
  Continue cont;
  Query query;

  WikiResponse({this.batchcomplete, this.cont, this.query});

  WikiResponse.fromJson(Map<String, dynamic> json) {
    batchcomplete = json['batchcomplete'];
    cont = json['continue'] != null
        ? new Continue.fromJson(json['continue'])
        : null;
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchcomplete'] = this.batchcomplete;
    if (this.cont != null) {
      data['continue'] = this.cont.toJson();
    }
    if (this.query != null) {
      data['query'] = this.query.toJson();
    }
    return data;
  }
}



