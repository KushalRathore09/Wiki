class Redirects {
  int index;
  String from;
  String to;

  Redirects({this.index, this.from, this.to});

  Redirects.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}