import 'dart:convert';

import 'package:easy_food/model/MaterialModel.dart';
import 'package:http/http.dart' as http;

class MaterialApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<MaterialModel> getMaterials(String customerId) async {
    final apiUrl = Uri.parse(
        baseUrl + "Product/getProductMaterial?xcustomer_id=" + customerId);

    var responseMaterials = await client.get(apiUrl);
    if (responseMaterials != null && responseMaterials.statusCode == 200) {
      final resJson = jsonDecode(responseMaterials.body);
      return MaterialModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }
}
