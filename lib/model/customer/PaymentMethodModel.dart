class PaymentMethodModel {
  List<Payment> data;

  PaymentMethodModel({this.data});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Payment>[];
      json['data'].forEach((v) {
        data.add(new Payment.fromJson(v));
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

class Payment {
  String frmPaymentMethodId;
  String name;
  String description;
  String versionNo;
  String insertUserId;
  String insertDttm;
  String versionUserId;
  String versionDttm;

  Payment(
      {this.frmPaymentMethodId,
      this.name,
      this.description,
      this.versionNo,
      this.insertUserId,
      this.insertDttm,
      this.versionUserId,
      this.versionDttm});

  Payment.fromJson(Map<String, dynamic> json) {
    frmPaymentMethodId = json['frm_payment_method_id'];
    name = json['name'];
    description = json['description'];
    versionNo = json['version_no'];
    insertUserId = json['insert_user_id'];
    insertDttm = json['insert_dttm'];
    versionUserId = json['version_user_id'];
    versionDttm = json['version_dttm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_payment_method_id'] = this.frmPaymentMethodId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['version_no'] = this.versionNo;
    data['insert_user_id'] = this.insertUserId;
    data['insert_dttm'] = this.insertDttm;
    data['version_user_id'] = this.versionUserId;
    data['version_dttm'] = this.versionDttm;
    return data;
  }
}
