import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var _pageIndex = 2.obs;
  var _currentIconColor = [
    Color(0xFF545D68),
    Color(0xFF545D68),
    Colors.black,
    Color(0xFF545D68),
    Color(0xFF545D68)
  ].obs;

  var pageTitle = [
    "Adreslerim",
    "Profilim",
    "Restoranlar",
    "Siparişleirm",
    "Sepetim",
  ].obs;

  int get selectedIndex => this._pageIndex.value;

  List<Color> get currentIconColor => this._currentIconColor();
  set currentIconColor(List<Color> index) => this._currentIconColor(index);

  void navigationTransition(int index) {
    _pageIndex(index);
    if (index == 0) {
      currentIconColor = [
        Colors.black,
        Color(0xFF545D68),
        Color(0xFF545D68),
        Color(0xFF545D68),
        Color(0xFF545D68)
      ];
    } else if (index == 1) {
      currentIconColor = [
        Color(0xFF545D68),
        Colors.black,
        Color(0xFF545D68),
        Color(0xFF545D68),
        Color(0xFF545D68)
      ];
    } else if (index == 2) {
      currentIconColor = [
        Color(0xFF545D68),
        Color(0xFF545D68),
        Colors.black,
        Color(0xFF545D68),
        Color(0xFF545D68)
      ];
    } else if (index == 3) {
      currentIconColor = [
        Color(0xFF545D68),
        Color(0xFF545D68),
        Color(0xFF545D68),
        Colors.black,
        Color(0xFF545D68)
      ];
    } else if (index == 4) {
      currentIconColor = [
        Color(0xFF545D68),
        Color(0xFF545D68),
        Color(0xFF545D68),
        Color(0xFF545D68),
        Colors.black,
      ];
    }
  }
}
