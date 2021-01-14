class OrderModel {
  int formId;
  bool success;
  Outs outs;

  OrderModel({this.formId, this.success, this.outs});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
  int frmOrderDetailId;

  Outs({this.frmOrderDetailId});

  Outs.fromJson(Map<String, dynamic> json) {
    frmOrderDetailId = json['frm_order_detail_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_order_detail_id'] = this.frmOrderDetailId;
    return data;
  }
}
