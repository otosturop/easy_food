class OrderPrepareModel {
  int formId;
  bool success;
  Outs outs;

  OrderPrepareModel({this.formId, this.success, this.outs});

  OrderPrepareModel.fromJson(Map<String, dynamic> json) {
    formId = json['formId'];
    success = json['success'];
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formId'] = this.formId;
    data['success'] = this.success;
    if (this.outs != null) {
      data['outs'] = this.outs.toJson();
    }
    return data;
  }
}

class Outs {
  int frmOrdersId;

  Outs({this.frmOrdersId});

  Outs.fromJson(Map<String, dynamic> json) {
    frmOrdersId = json['frm_orders_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_orders_id'] = this.frmOrdersId;
    return data;
  }
}
