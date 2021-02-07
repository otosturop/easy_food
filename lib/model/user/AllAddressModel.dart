class AllAddressModel {
  bool success;
  int queryId;
  String execDttm;
  List<AddData> data;

  AllAddressModel({this.success, this.queryId, this.execDttm, this.data});

  AllAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    queryId = json['queryId'];
    execDttm = json['execDttm'];
    if (json['data'] != null) {
      data = <AddData>[];
      json['data'].forEach((v) {
        data.add(new AddData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['queryId'] = this.queryId;
    data['execDttm'] = this.execDttm;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddData {
  String frmUserAdressId;
  bool isDefault;
  String userId;
  String location;
  String addressType;
  String addressTypeQw;
  String deliveryArea;
  String deliveryInstructions;
  String complateAddress;
  String cityId;
  String countiesId;
  String areaId;
  String neighborhoodsId;

  AddData(
      {this.frmUserAdressId,
      this.isDefault,
      this.userId,
      this.location,
      this.addressType,
      this.addressTypeQw,
      this.deliveryArea,
      this.deliveryInstructions,
      this.complateAddress,
      this.cityId,
      this.countiesId,
      this.areaId,
      this.neighborhoodsId});

  AddData.fromJson(Map<String, dynamic> json) {
    frmUserAdressId = json['frm_user_adress_id'];
    isDefault = json['is_default'];
    userId = json['user_id'];
    location = json['location'];
    addressType = json['address_type'];
    addressTypeQw = json['address_type_qw_'];
    deliveryArea = json['delivery_area'];
    deliveryInstructions = json['delivery_instructions'];
    complateAddress = json['complate_address'];
    cityId = json['city_id'];
    countiesId = json['counties_id'];
    areaId = json['area_id'];
    neighborhoodsId = json['neighborhoods_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frm_user_adress_id'] = this.frmUserAdressId;
    data['is_default'] = this.isDefault;
    data['user_id'] = this.userId;
    data['location'] = this.location;
    data['address_type'] = this.addressType;
    data['address_type_qw_'] = this.addressTypeQw;
    data['delivery_area'] = this.deliveryArea;
    data['delivery_instructions'] = this.deliveryInstructions;
    data['complate_address'] = this.complateAddress;
    data['city_id'] = this.cityId;
    data['counties_id'] = this.countiesId;
    data['area_id'] = this.areaId;
    data['neighborhoods_id'] = this.neighborhoodsId;
    return data;
  }
}
