import 'dart:convert';

import 'package:easy_food/model/CategoriesModel.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<CategoriesModel> getCategories(String customerId) async {
    final apiUrl =
        baseUrl + "Product/getProductCategoriesList?xcustomer_id=" + customerId;
    var responseCategories = await client.get(apiUrl);
    if (responseCategories != null && responseCategories.statusCode == 200) {
      final resJson = jsonDecode(responseCategories.body);
      return CategoriesModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }
}
