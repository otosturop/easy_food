import 'dart:convert';
import 'package:easy_food/model/OrderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:easy_food/model/OrderPrepareModel.dart';
import 'package:http/http.dart' as http;

class OrdersApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  final Map<String, String> headers = {"content-type": "application/json"};
  var client = http.Client();

  Future<OrderPrepareModel> getOrderId(
      userId, adressId, paymentMethot, price, customerId, orderNote) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm:ss');
    final String formattedTime = formatter.format(now);
    debugPrint(formattedTime);

    final apiUrl = Uri.parse(baseUrl + "Orders/addOrders");
    final postBody = jsonEncode({
      'user_id': userId,
      'address_id': adressId,
      'payment_methods': paymentMethot,
      'total_price': price,
      'channel_type_id': '3',
      'customer_id': customerId,
      'order_status_id': '1',
      'order_description': orderNote,
      'order_date': formattedTime,
    });
    var responseOrder =
        await client.post(apiUrl, headers: headers, body: postBody);
    if (responseOrder != null && responseOrder.statusCode == 200) {
      Map result = json.decode(responseOrder.body);
      debugPrint(result.toString());
      return OrderPrepareModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<OrderModel> sendOrder(orderId, productId, materialRemoved, materialAdd,
      price, quantity, option, customerId) async {
    final apiUrl = Uri.parse(baseUrl + "Orders/addOrderDetail");
    final postBody = jsonEncode({
      'order_id': orderId,
      'product_id': productId,
      'material_removed': materialRemoved,
      'material_add': materialAdd,
      'price': price,
      'quantity': quantity,
      'options': option,
      'customer_id': customerId
    });
    var responseOrder =
        await client.post(apiUrl, headers: headers, body: postBody);
    if (responseOrder != null && responseOrder.statusCode == 200) {
      Map result = jsonDecode(responseOrder.body);
      return OrderModel.fromJson(result);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
