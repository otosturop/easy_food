import 'dart:convert';

import 'package:easy_food/model/user/OrdersHistoryModel.dart';
import 'package:http/http.dart' as http;

class OrdersHistory {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<OrdersHistoryModel> getOrdersHistory(userId) async {
    final apiUrl = Uri.parse(baseUrl + "Orders/getOrder?xuser_id=" + userId);
    var responseInfo = await client.get(apiUrl);
    if (responseInfo != null && responseInfo.statusCode == 200) {
      final resJson = jsonDecode(responseInfo.body);
      return OrdersHistoryModel.fromJson(resJson);
    } else {
      throw Exception("Veri Getirilemedi");
    }
  }
}
