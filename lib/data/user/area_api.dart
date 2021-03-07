import 'dart:convert';

import 'package:easy_food/model/user/AreaModel.dart';
import 'package:http/http.dart' as http;

class AreaApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<AreaModel> getArea(countyId) async {
    final apiUrl = Uri.parse(baseUrl + "Address/getArea?xcountyid=" + countyId);
    var responseArea = await client.get(apiUrl);
    if (responseArea != null && responseArea.statusCode == 200) {
      final resJson = jsonDecode(responseArea.body);
      return AreaModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }
}
