class Continue {
  int gpsoffset;
  String cont;

  Continue({this.gpsoffset, this.cont});

  Continue.fromJson(Map<String, dynamic> json) {
    gpsoffset = json['gpsoffset'];
    cont = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpsoffset'] = this.gpsoffset;
    data['continue'] = this.cont;
    return data;
  }
}