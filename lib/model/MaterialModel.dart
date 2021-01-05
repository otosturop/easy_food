class MaterialModel {
  List<Data> data;

  MaterialModel({this.data});

  MaterialModel.fromJson(Map<String, dynamic> json) {
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
  String frmProductMaterialsId;
  String productMaterials;
  String amount;
  String productCategoriesId;
  String customerId;

  Data(
      {this.frmProductMaterialsId,
      this.productMaterials,
      this.amount,
      this.productCategoriesId,
      this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    frmProductMaterialsId = json['frm_product_materials_id'];
    productMaterials = json['product_materials'];
    amount = json['amount'];
    productCategoriesId = json['product_categories_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_product_materials_id'] = this.frmProductMaterialsId;
    data['product_materials'] = this.productMaterials;
    data['amount'] = this.amount;
    data['product_categories_id'] = this.productCategoriesId;
    data['customer_id'] = this.customerId;
    return data;
  }
}
