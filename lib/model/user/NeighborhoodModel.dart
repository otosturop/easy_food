class NeighborhoodModel {
  bool success;
  String execDttm;
  List<Neighborhood> data;

  NeighborhoodModel({this.success, this.execDttm, this.data});

  NeighborhoodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    execDttm = json['execDttm'];
    if (json['data'] != null) {
      data = <Neighborhood>[];
      json['data'].forEach((v) {
        data.add(new Neighborhood.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['execDttm'] = this.execDttm;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Neighborhood {
  String dsc;
  String id;

  Neighborhood({this.dsc, this.id});

  Neighborhood.fromJson(Map<String, dynamic> json) {
    dsc = json['dsc'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsc'] = this.dsc;
    data['id'] = this.id;
    return data;
  }
}
