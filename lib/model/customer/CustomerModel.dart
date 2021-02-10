class CustomerModel {
  List<Data> data;

  CustomerModel({this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
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
  String frmCustomerId;
  String minimumOrderPrice;
  String paymentMethodId;
  String phoneNumber;
  String name;
  String workTimeStart;
  String orderTime;
  String warningsInformation;
  String additionalInformation;
  String logoPath;
  String username;
  String passwordHash;
  String passwordSalt;
  String information;
  String metaData;
  String roleId;
  String customerLocation;
  String customerMetaData;
  String customerStatus;
  String customerStatusQw;
  String customerOtherAddress;
  bool isOtherAddress;
  String currencyUnit;
  String workTimeEnd;
  String domainCustomerId;
  String categories;
  String features;
  String cuisines;
  String minMoney;
  String cityId;
  String countiesId;
  String countriesId;
  String areaId;
  String neighborhoodsId;
  String subLogo;
  String email;

  Data(
      {this.frmCustomerId,
      this.minimumOrderPrice,
      this.paymentMethodId,
      this.phoneNumber,
      this.name,
      this.workTimeStart,
      this.orderTime,
      this.warningsInformation,
      this.additionalInformation,
      this.logoPath,
      this.username,
      this.passwordHash,
      this.passwordSalt,
      this.information,
      this.metaData,
      this.roleId,
      this.customerLocation,
      this.customerMetaData,
      this.customerStatus,
      this.customerStatusQw,
      this.customerOtherAddress,
      this.isOtherAddress,
      this.currencyUnit,
      this.workTimeEnd,
      this.domainCustomerId,
      this.categories,
      this.features,
      this.cuisines,
      this.minMoney,
      this.cityId,
      this.countiesId,
      this.countriesId,
      this.areaId,
      this.neighborhoodsId,
      this.subLogo,
      this.email});

  Data.fromJson(Map<String, dynamic> json) {
    frmCustomerId = json['frm_customer_id'];
    minimumOrderPrice = json['minimum_order_price'];
    paymentMethodId = json['payment_method_id'];
    phoneNumber = json['phone_number'];
    name = json['name'];
    workTimeStart = json['work_time_start'];
    orderTime = json['order_time'];
    warningsInformation = json['warnings_information'];
    additionalInformation = json['additional_information'];
    logoPath = json['logo_path'];
    username = json['username'];
    passwordHash = json['password_hash'];
    passwordSalt = json['password_salt'];
    information = json['information'];
    metaData = json['meta_data'];
    roleId = json['role_id'];
    customerLocation = json['customer_location'];
    customerMetaData = json['customer_meta_data'];
    customerStatus = json['customer_status'];
    customerStatusQw = json['customer_status_qw_'];
    customerOtherAddress = json['customer_other_address'];
    isOtherAddress = json['is_other_address'];
    currencyUnit = json['currency_unit'];
    workTimeEnd = json['work_time_end'];
    domainCustomerId = json['domain_customer_id'];
    categories = json['categories'];
    features = json['features'];
    cuisines = json['cuisines'];
    minMoney = json['min_money'];
    cityId = json['city_id'];
    countiesId = json['counties_id'];
    countriesId = json['countries_id'];
    areaId = json['area_id'];
    neighborhoodsId = json['neighborhoods_id'];
    subLogo = json['sub_logo'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_customer_id'] = this.frmCustomerId;
    data['minimum_order_price'] = this.minimumOrderPrice;
    data['payment_method_id'] = this.paymentMethodId;
    data['phone_number'] = this.phoneNumber;
    data['name'] = this.name;
    data['work_time_start'] = this.workTimeStart;
    data['order_time'] = this.orderTime;
    data['warnings_information'] = this.warningsInformation;
    data['additional_information'] = this.additionalInformation;
    data['logo_path'] = this.logoPath;
    data['username'] = this.username;
    data['password_hash'] = this.passwordHash;
    data['password_salt'] = this.passwordSalt;
    data['information'] = this.information;
    data['meta_data'] = this.metaData;
    data['role_id'] = this.roleId;
    data['customer_location'] = this.customerLocation;
    data['customer_meta_data'] = this.customerMetaData;
    data['customer_status'] = this.customerStatus;
    data['customer_status_qw_'] = this.customerStatusQw;
    data['customer_other_address'] = this.customerOtherAddress;
    data['is_other_address'] = this.isOtherAddress;
    data['currency_unit'] = this.currencyUnit;
    data['work_time_end'] = this.workTimeEnd;
    data['domain_customer_id'] = this.domainCustomerId;
    data['categories'] = this.categories;
    data['features'] = this.features;
    data['cuisines'] = this.cuisines;
    data['min_money'] = this.minMoney;
    data['city_id'] = this.cityId;
    data['counties_id'] = this.countiesId;
    data['countries_id'] = this.countriesId;
    data['area_id'] = this.areaId;
    data['neighborhoods_id'] = this.neighborhoodsId;
    data['sub_logo'] = this.subLogo;
    data['email'] = this.email;
    return data;
  }
}
