import 'package:easy_food/data/user/address_api.dart';
import 'package:easy_food/data/user/area_api.dart';
import 'package:easy_food/model/user/AddressModel.dart';
import 'package:easy_food/model/user/AllAddressModel.dart';
import 'package:easy_food/model/user/AreaModel.dart';
import 'package:easy_food/model/user/NeighborhoodModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressController extends GetxController {
  var selectedCounties = List<AdressData>.empty().obs;
  var allAddress = List<AddData>.empty().obs;
  var selectedAreas = List<Data>.empty().obs;
  var selectedNeighborhoods = List<Neighborhood>.empty().obs;
  var loadingCounties = false.obs;
  var tempCountyVal = RxString(null);
  var tempTypeVal = RxString(null);
  var tempAreaVal = RxString(null);
  var tempAddressVal = RxString(null);
  var tempNeighborhoodVal = RxString(null);
  String textAddress;
  var loadingCounty = false.obs;
  var loadingAllAddress = false.obs;
  var loadingArea = false.obs;
  var loadingNeighborhood = false.obs;
  var insertAddressStatus = false.obs;
  var editAddress = false.obs;
  var editId = "".obs;
  List<Map<String, String>> adressType = [
    {
      "id": "1",
      "type": "Ev",
    },
    {
      "id": "2",
      "type": "İş Yeri",
    },
    {
      "id": "3",
      "type": "Diğer",
    }
  ];
  AddressApi _addressApi = AddressApi();
  AreaApi _areaApi = AreaApi();

  @override
  void onInit() async {
    String userId = await getUserId();
    getAllAddress(userId);
    getCounties("7");
    super.onInit();
  }

  void addAdressStatusChange(String id, {type}) {
    if (id == "-1") {
      insertAddressStatus.value = !insertAddressStatus.value;
      iconStatus();
      editAddress.value = false;
    } else {
      insertAddressStatus.value = !insertAddressStatus.value;
      iconStatus();
      selectedType(type);
      editAddress.value = true;
      editId.value = id;
    }
  }

  Icon iconStatus() {
    return insertAddressStatus.value ? Icon(Icons.close) : Icon(Icons.add);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    return userId;
  }

  void selectedCounty(county) => tempCountyVal.value = county;

  void selectedType(type) => tempTypeVal.value = type;

  void selectedArea(area) => tempAreaVal.value = area;

  void selectedAddress(adressId) => tempAddressVal.value = adressId;

  void selectedNeighborhood(id) => tempNeighborhoodVal.value = id;

  void assignTextAddress(address) => textAddress = address;

  Future<void> getCounties(cityId) async {
    try {
      loadingCounties(false);
      var counties = await _addressApi.getCounties(cityId);
      if (counties != null) {
        selectedCounties(counties.data);
      }
    } finally {
      loadingCounties(true);
    }
  }

  Future<void> getArea(countyId) async {
    try {
      loadingArea(false);
      var area = await _areaApi.getArea(countyId);
      if (area != null) {
        selectedAreas(area.data);
      }
    } finally {
      loadingArea(true);
    }
  }

  Future<void> getAllAddress(userId) async {
    try {
      loadingAllAddress(false);
      var allAddresses = await _addressApi.getAllAdress(userId);
      if (allAddresses != null) {
        allAddress(allAddresses.data);
      }
    } finally {
      loadingAllAddress(true);
    }
  }

  Future<void> getNeighborhood(areaId) async {
    try {
      loadingNeighborhood(false);
      var neighborhood = await _addressApi.getNeighborhood(areaId);
      if (neighborhood != null) {
        selectedNeighborhoods(neighborhood.data);
      }
    } finally {
      loadingNeighborhood(true);
    }
  }

  Future<void> addAddress() async {
    String userId = await getUserId();
    try {
      var status = await _addressApi.addAddress(
          userId,
          tempTypeVal.value,
          textAddress,
          "7",
          tempCountyVal.value,
          tempCountyVal.value,
          tempNeighborhoodVal.value);
      if (status.success) {
        insertAddressStatus.value = false;
        getAllAddress(userId);
      }
    } finally {}
  }

  Future<void> updateAddress() async {
    String userId = await getUserId();
    try {
      var status = await _addressApi.updateAddress(
          editId.value,
          userId,
          tempTypeVal.value,
          textAddress,
          "7",
          tempCountyVal.value,
          tempCountyVal.value,
          tempNeighborhoodVal.value);
      if (status.success) {
        insertAddressStatus.value = false;
        editAddress.value = false;
        getAllAddress(userId);
      }
    } finally {}
  }

  Future<void> removeAddress(addressId) async {
    String userId = await getUserId();
    try {
      var status = await _addressApi.removeAddress(addressId);
      if (status.success) {
        insertAddressStatus.value = false;
        getAllAddress(userId);
      }
    } finally {}
  }
}
