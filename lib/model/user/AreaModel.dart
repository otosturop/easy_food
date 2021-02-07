class AreaModel {
  List<Data> data;

  AreaModel({this.data});

  AreaModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String areasId;
  String areaname;

  Data({this.areasId, this.areaname});

  Data.fromJson(Map<String, dynamic> json) {
    areasId = json['areas_id'];
    areaname = json['areaname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['areas_id'] = this.areasId;
    data['areaname'] = this.areaname;
    return data;
  }
}
