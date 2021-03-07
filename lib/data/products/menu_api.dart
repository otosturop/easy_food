import 'dart:convert';

import 'package:easy_food/model/MenuMaterialModel.dart';
import 'package:http/http.dart' as http;

class MenuApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<MenuMaterialModel> getMenus(String productId) async {
    final apiUrl = Uri.parse(
        baseUrl + "Product/getProductDetailList?xproduct_id=" + productId);

    var responseMenu = await client.get(apiUrl);
    if (responseMenu != null && responseMenu.statusCode == 200) {
      final resJson = jsonDecode(responseMenu.body);
      return MenuMaterialModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }
}
