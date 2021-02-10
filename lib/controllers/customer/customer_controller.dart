import 'package:easy_food/data/customer/customer_api.dart';
import 'package:easy_food/model/customer/CustomerModel.dart';
import 'package:easy_food/model/customer/CustomerInfoModel.dart';
import 'package:easy_food/model/customer/PaymentMethodModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPayment = true.obs;
  var allCustomers = List<Data>.empty().obs;
  var customer = List<Info>.empty().obs;
  var paymentMethod = List<Payment>.empty().obs;
  CustomerApi _api = CustomerApi();

  @override
  void onInit() async {
    getPaymentMethod();
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
        debugPrint("something went wrong");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCustomerInfo(customerId) async {
    try {
      var custonerInfo = await _api.customerInfo(customerId);
      if (custonerInfo != null) {
        customer(custonerInfo.data);
      } else {
        debugPrint("something went wrong");
      }
    } finally {}
  }

  Future<void> getPaymentMethod() async {
    isLoadingPayment(true);
    try {
      var payment = await _api.getPaymentMethod();
      if (payment != null) {
        paymentMethod(payment.data);
      } else {
        debugPrint("something went wrong");
      }
    } finally {
      isLoadingPayment(false);
    }
  }

  String matchPaymentMethod(id) {
    var method = paymentMethod.firstWhere((e) => e.frmPaymentMethodId == id);
    return method.name;
  }
}
