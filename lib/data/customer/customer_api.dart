import 'dart:convert';

import 'package:easy_food/model/CustomerModel.dart';
import 'package:http/http.dart' as http;

class CustomerApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<CustomerModel> getCustomers() async {
    final apiUrl = baseUrl + "Customer/getCustomerList";
    var responseCustomers = await client.get(apiUrl);
    if (responseCustomers != null && responseCustomers.statusCode == 200) {
      final resJson = jsonDecode(responseCustomers.body);
      return CustomerModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }
}
