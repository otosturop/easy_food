import 'dart:convert';
import 'package:easy_food/model/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<ProductModel> getProducts(String customerId, String categoryId) async {
    final apiUrl = Uri.parse(baseUrl +
        "Product/getProductsList?xcustomer_id=" +
        customerId +
        "xproduct_category_id=" +
        categoryId);
    var responseProducts = await client.get(apiUrl);
    if (responseProducts != null && responseProducts.statusCode == 200) {
      final resJson = jsonDecode(responseProducts.body);
      return ProductModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }

  Future<ProductModel> getAllProducts() async {
    final apiUrl = Uri.parse(baseUrl + "Product/getProductsList?xcustomer_id=");
    var responseAllProducts = await client.get(apiUrl);
    if (responseAllProducts != null && responseAllProducts.statusCode == 200) {
      final resJson = jsonDecode(responseAllProducts.body);
      return ProductModel.fromJson(resJson);
    } else {
      debugPrint("ad");
      throw Exception("Veri Getirilemedi");
    }
  }
}
