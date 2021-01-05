import 'package:easy_food/data/customer/customer_api.dart';
import 'package:easy_food/model/CustomerModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  var isLoading = true.obs;
  var allCustomers = List<Data>.empty().obs;
  CustomerApi _api = CustomerApi();

  @override
  void onInit() async {
    fetchCustomers();
    super.onInit();
  }

  Future<void> fetchCustomers() async {
    try {
      isLoading(true);
      var customers = await _api.getCustomers();
      if (customers != null) {
        allCustomers(customers.data);
      } else {
        debugPrint("hataa");
      }
    } finally {
      isLoading(false);
    }
  }
}
