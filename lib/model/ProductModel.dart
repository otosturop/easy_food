class ProductModel {
  List<Data> data;

  ProductModel({this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  String frmProductId;
  String productCategoryId;
  String name;
  String orderNumber;
  String description;
  String price;
  String tax;
  String portion;
  String portionQw;
  String prepationTime;
  bool mostPopulars;
  bool bestSellers;
  String versionNo;
  String insertUserId;
  String insertDttm;
  String versionUserId;
  String versionDttm;
  String productMaterials;
  String materialsRemoved;
  String photo;
  String productSubCategories;
  bool isNew;
  bool isMenu;
  String customerId;

  Data(
      {this.frmProductId,
      this.productCategoryId,
      this.name,
      this.orderNumber,
      this.description,
      this.price,
      this.tax,
      this.portion,
      this.portionQw,
      this.prepationTime,
      this.mostPopulars,
      this.bestSellers,
      this.versionNo,
      this.insertUserId,
      this.insertDttm,
      this.versionUserId,
      this.versionDttm,
      this.productMaterials,
      this.materialsRemoved,
      this.photo,
      this.productSubCategories,
      this.isNew,
      this.isMenu,
      this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    frmProductId = json['frm_product_id'];
    productCategoryId = json['product_category_id'];
    name = json['name'];
    orderNumber = json['order_number'];
    description = json['description'];
    price = json['price'];
    tax = json['tax'];
    portion = json['portion'];
    portionQw = json['portion_qw_'];
    prepationTime = json['prepation_time'];
    mostPopulars = json['most_populars'];
    bestSellers = json['best_sellers'];
    versionNo = json['version_no'];
    insertUserId = json['insert_user_id'];
    insertDttm = json['insert_dttm'];
    versionUserId = json['version_user_id'];
    versionDttm = json['version_dttm'];
    productMaterials = json['product_materials'];
    materialsRemoved = json['materials_removed'];
    photo = json['photo'];
    productSubCategories = json['product_sub_categories'];
    isNew = json['is_new'];
    isMenu = json['is_menu'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_product_id'] = this.frmProductId;
    data['product_category_id'] = this.productCategoryId;
    data['name'] = this.name;
    data['order_number'] = this.orderNumber;
    data['description'] = this.description;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['portion'] = this.portion;
    data['portion_qw_'] = this.portionQw;
    data['prepation_time'] = this.prepationTime;
    data['most_populars'] = this.mostPopulars;
    data['best_sellers'] = this.bestSellers;
    data['version_no'] = this.versionNo;
    data['insert_user_id'] = this.insertUserId;
    data['insert_dttm'] = this.insertDttm;
    data['version_user_id'] = this.versionUserId;
    data['version_dttm'] = this.versionDttm;
    data['product_materials'] = this.productMaterials;
    data['materials_removed'] = this.materialsRemoved;
    data['photo'] = this.photo;
    data['product_sub_categories'] = this.productSubCategories;
    data['is_new'] = this.isNew;
    data['is_menu'] = this.isMenu;
    data['customer_id'] = this.customerId;
    return data;
  }
}
