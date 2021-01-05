class CategoriesModel {
  List<Data> data;

  CategoriesModel({this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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
  String frmProductCategoriesId;
  String name;
  String description;
  String orderNumber;
  String listType;
  String listTypeQw;
  String customerId;

  Data(
      {this.frmProductCategoriesId,
        this.name,
        this.description,
        this.orderNumber,
        this.listType,
        this.listTypeQw,
        this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    frmProductCategoriesId = json['frm_product_categories_id'];
    name = json['name'];
    description = json['description'];
    orderNumber = json['order_number'];
    listType = json['list_type'];
    listTypeQw = json['list_type_qw_'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_product_categories_id'] = this.frmProductCategoriesId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['order_number'] = this.orderNumber;
    data['list_type'] = this.listType;
    data['list_type_qw_'] = this.listTypeQw;
    data['customer_id'] = this.customerId;
    return data;
  }
}
