import 'dart:convert';

import 'package:easy_food/model/user/AddressModel.dart';
import 'package:easy_food/model/user/AllAddressModel.dart';
import 'package:easy_food/model/user/NeighborhoodModel.dart';
import 'package:http/http.dart' as http;

class AddressApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<AddressModel> getCounties(cityId) async {
    final apiUrl = baseUrl + "Address/getCounties?xcityid=" + cityId;
    var responseCounties = await client.get(apiUrl);
    if (responseCounties != null && responseCounties.statusCode == 200) {
      final resJson = jsonDecode(responseCounties.body);
      return AddressModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }

  Future<AllAddressModel> getAllAdress(userId) async {
    final apiUrl = baseUrl + "Users/getUserAddress?xuser_id=" + userId;
    var responseAllAddress = await client.get(apiUrl);
    if (responseAllAddress != null && responseAllAddress.statusCode == 200) {
      final resJson = jsonDecode(responseAllAddress.body);
      return AllAddressModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }

  Future<NeighborhoodModel> getNeighborhood(areaId) async {
    final apiUrl = baseUrl + "Address/getNeighborhoods?xareaid=" + areaId;
    var responseNeighborhood = await client.get(apiUrl);
    if (responseNeighborhood != null &&
        responseNeighborhood.statusCode == 200) {
      final resJson = jsonDecode(responseNeighborhood.body);
      return NeighborhoodModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }
}
