class AddAddressModel {
  bool success;
  Outs outs;

  AddAddressModel({this.success, this.outs});

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.outs != null) {
      data['outs'] = this.outs.toJson();
    }
    return data;
  }
}

class Outs {
  int frmUserAdressId;

  Outs({this.frmUserAdressId});

  Outs.fromJson(Map<String, dynamic> json) {
    frmUserAdressId = json['frm_user_adress_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_user_adress_id'] = this.frmUserAdressId;
    return data;
  }
}
