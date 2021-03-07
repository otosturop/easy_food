import 'dart:convert';

import 'package:easy_food/model/customer/CustomerInfoModel.dart';
import 'package:easy_food/model/customer/CustomerModel.dart';
import 'package:easy_food/model/customer/PaymentMethodModel.dart';
import 'package:http/http.dart' as http;

class CustomerApi {
  static const baseUrl =
      "http://206.189.55.20:8080/rest/276ce05d-837b-4aa1-8f6f-ff02597a0e01/";
  var client = http.Client();

  Future<CustomerModel> getCustomers() async {
    final apiUrl = Uri.parse(baseUrl + "Customer/getCustomerList");
    var responseCustomers = await client.get(apiUrl);
    if (responseCustomers != null && responseCustomers.statusCode == 200) {
      final resJson = jsonDecode(responseCustomers.body);
      return CustomerModel.fromJson(resJson);
    } else {
      throw Exception("customer Veri Getirilemedi");
    }
  }

  Future<CustomerInfoModel> customerInfo(customerId) async {
    final apiUrl = Uri.parse(
        baseUrl + "Customer/getCustomerInfo?xcustomer_id=" + customerId);
    var responseCustomer = await client.get(apiUrl);
    if (responseCustomer != null && responseCustomer.statusCode == 200) {
      final resJson = jsonDecode(responseCustomer.body);
      return CustomerInfoModel.fromJson(resJson);
    } else {
      throw Exception("Customet InfoVeri Getirilemedi");
    }
  }

  Future<PaymentMethodModel> getPaymentMethod() async {
    final apiUrl = Uri.parse(baseUrl + "Customer/getPaymentMethod");
    var responsePayment = await client.get(apiUrl);
    if (responsePayment != null && responsePayment.statusCode == 200) {
      final resJson = jsonDecode(responsePayment.body);
      return PaymentMethodModel.fromJson(resJson);
    } else {
      throw Exception("Payment Veri Getirilemedi");
    }
  }
}
