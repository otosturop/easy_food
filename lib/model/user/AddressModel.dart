class AddressModel {
  bool success;
  String execDttm;
  List<AdressData> data;

  AddressModel({this.success, this.execDttm, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    execDttm = json['execDttm'];
    if (json['data'] != null) {
      data = <AdressData>[];
      json['data'].forEach((v) {
        data.add(new AdressData.fromJson(v));
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

class AdressData {
  String countiesId;
  String countyname;

  AdressData({this.countiesId, this.countyname});

  AdressData.fromJson(Map<String, dynamic> json) {
    countiesId = json['counties_id'];
    countyname = json['countyname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counties_id'] = this.countiesId;
    data['countyname'] = this.countyname;
    return data;
  }
}
