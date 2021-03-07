import 'dart:convert';

import 'package:easy_food/model/user/AddAddressModel.dart';
import 'package:easy_food/model/user/AddressModel.dart';
import 'package:easy_food/model/user/AllAddressModel.dart';
import 'package:easy_food/model/user/NeighborhoodModel.dart';
import 'package:easy_food/model/user/RemoveAddressModel.dart';
import 'package:http/http.dart' as http;

class AddressApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();
  final Map<String, String> headers = {"content-type": "application/json"};

  Future<AddressModel> getCounties(cityId) async {
    final apiUrl = Uri.parse(baseUrl + "Address/getCounties?xcityid=" + cityId);
    var responseCounties = await client.get(apiUrl);
    if (responseCounties != null && responseCounties.statusCode == 200) {
      final resJson = jsonDecode(responseCounties.body);
      return AddressModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }

  Future<AllAddressModel> getAllAdress(userId) async {
    final apiUrl =
        Uri.parse(baseUrl + "Users/getUserAddress?xuser_id=" + userId);
    var responseAllAddress = await client.get(apiUrl);
    if (responseAllAddress != null && responseAllAddress.statusCode == 200) {
      final resJson = jsonDecode(responseAllAddress.body);
      return AllAddressModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }

  Future<NeighborhoodModel> getNeighborhood(areaId) async {
    final apiUrl =
        Uri.parse(baseUrl + "Address/getNeighborhoods?xareaid=" + areaId);
    var responseNeighborhood = await client.get(apiUrl);
    if (responseNeighborhood != null &&
        responseNeighborhood.statusCode == 200) {
      final resJson = jsonDecode(responseNeighborhood.body);
      return NeighborhoodModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }

  Future<AddAddressModel> addAddress(userId, addressType, textAddress, cityId,
      countiesId, areaId, neighborhoodId) async {
    final apiUrl = Uri.parse(baseUrl + "Users/addUserAddress");
    final postBody = jsonEncode({
      'user_id': userId,
      "address_type": addressType,
      "complate_address": textAddress,
      "city_id": cityId,
      "counties_id": countiesId,
      "area_id": areaId,
      "neighborhoods_id": neighborhoodId,
    });
    var responseStatus =
        await client.post(apiUrl, headers: headers, body: postBody);
    if (responseStatus != null && responseStatus.statusCode == 200) {
      Map result = json.decode(responseStatus.body);
      return AddAddressModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<AddAddressModel> updateAddress(addressId, userId, addressType,
      textAddress, cityId, countiesId, areaId, neighborhoodId) async {
    final apiUrl = Uri.parse(baseUrl + "Users/updateUserAddress");
    final postBody = jsonEncode({
      'tfrm_user_adress_id': addressId,
      'user_id': userId,
      "address_type": addressType,
      "complate_address": textAddress,
      "city_id": cityId,
      "counties_id": countiesId,
      "area_id": areaId,
      "neighborhoods_id": neighborhoodId,
    });
    var responseStatus =
        await client.post(apiUrl, headers: headers, body: postBody);
    if (responseStatus != null && responseStatus.statusCode == 200) {
      Map result = json.decode(responseStatus.body);
      return AddAddressModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<RemoveAddressModel> removeAddress(userAddressId) async {
    final apiUrl = Uri.parse(baseUrl + "Users/deleteUserAddress");
    final postBody = {
      'tfrm_user_adress_id': userAddressId,
    };
    var responseStatus = await client.post(apiUrl, body: postBody);
    if (responseStatus != null && responseStatus.statusCode == 200) {
      Map result = json.decode(responseStatus.body);
      return RemoveAddressModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
