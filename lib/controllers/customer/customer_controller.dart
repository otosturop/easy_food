import 'package:easy_food/data/customer/customer_api.dart';
import 'package:easy_food/model/customer/CustomerModel.dart';
import 'package:easy_food/model/customer/CustomerInfoModel.dart';
import 'package:easy_food/model/customer/PaymentMethodModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPayment = true.obs;
  var isLogin = false.obs;
  var allCustomers = List<Data>.empty().obs;
  var customer = List<Info>.empty().obs;
  var paymentMethod = List<Payment>.empty().obs;
  CustomerApi _api = CustomerApi();
  final String imgPath =
      "http://206.189.55.20:8080/preview/276ce05d-837b-4aa1-8f6f-ff02597a0e01/sf/x_file?_fai=";

  @override
  void onInit() async {
    getPaymentMethod();
    fetchCustomers();
    super.onInit();
  }

  Future getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      isLogin.value = false;
    } else {
      isLogin.value = true;
      update();
      String userId = prefs.getString('userId');
      return userId;
    }
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

  getCustomer(String customertId) {
    var product =
        allCustomers.firstWhere((i) => i.frmCustomerId == customertId);
    return product;
  }
}
