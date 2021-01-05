class MenuMaterialModel {
  List<Data> data;

  MenuMaterialModel({this.data});

  MenuMaterialModel.fromJson(Map<String, dynamic> json) {
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
  String productDetailsId;
  String categoryId;
  String subCategoryId;
  String productIds;
  String productId;
  String customerId;

  Data(
      {this.productDetailsId,
      this.categoryId,
      this.subCategoryId,
      this.productIds,
      this.productId,
      this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    productDetailsId = json['product_details_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    productIds = json['product_ids'];
    productId = json['product_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_details_id'] = this.productDetailsId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['product_ids'] = this.productIds;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    return data;
  }
}
