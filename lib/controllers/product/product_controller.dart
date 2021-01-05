import 'package:flutter/material.dart';
import 'package:easy_food/data/products/product_api.dart';
import 'package:get/state_manager.dart';
import 'package:easy_food/model/ProductModel.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = List<Data>.empty().obs;
  var allProducts = List<Data>.empty().obs;
  ProductApi _api = ProductApi();
  final String imgPath =
      "http://206.189.55.20:8080/preview/276ce05d-837b-4aa1-8f6f-ff02597a0e01/sf/x_file?_fai=";

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> fetchProducts(String customerId, String categoryId) async {
    try {
      isLoading(true);
      var products = await _api.getProducts(customerId, categoryId);
      if (products != null) {
        productList(products.data);
      } else {
        debugPrint("hataa");
      }
    } finally {
      isLoading(false);
    }
  }

  Future fetchAllProducts(String customerId) async {
    try {
      isLoading(true);
      var allProductPure = await _api.getAllProducts(customerId);
      if (allProductPure != null) {
        allProducts(allProductPure.data);
      }
    } finally {
      isLoading(false);
    }
  }

  List<Data> getListForCategory(String categoryId) {
    if (allProducts != null) {
      List<Data> filterProducts = List<Data>.of(
          allProducts.where((i) => i.productCategoryId == categoryId));
      return filterProducts;
    } else {
      fetchAllProducts("1");
      List<Data> filterProducts = List<Data>.of(
          allProducts.where((i) => i.productCategoryId == categoryId));
      return filterProducts;
    }
  }

  List getProduct(String productId) {
    List product =
        List.of(allProducts.where((i) => i.frmProductId == productId));
    return product;
  }
}
