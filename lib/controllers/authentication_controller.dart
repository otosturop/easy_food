import 'package:easy_food/data/auth/register_api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  RxBool _textPasswordType = true.obs;
  RegisterApi _api = RegisterApi();
  bool get textPasswordType => this._textPasswordType.value;

  void changeTypePassword() {
    _textPasswordType.value = !_textPasswordType.value;
  }

  void registerUser(fullname, email, phone, password) async {
    try {
      var userId = await _api.register(fullname, email, phone, password);
      debugPrint("User numarası: " + userId.outs.userId.toString());
      _api.assignRole(userId.outs.userId);
    } finally {}
  }

  void loginControl(userName, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var status = await _api.doLogin(userName, password);
      if (status.success) {
        prefs.setString('token', status.token.toString());
        print("token: " + prefs.getString('token'));
        bool checkValue = prefs.containsKey('token');
        print("check: " + checkValue.toString());
        //Get.to(FoodBasket());
      }
    } finally {}
  }
}
