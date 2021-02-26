import 'package:easy_food/data/products/product_api.dart';
import 'package:get/state_manager.dart';
import 'package:easy_food/model/ProductModel.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productListCategory = List<Data>.empty().obs;
  var productListCustomer = List<Data>.empty().obs;
  var allProducts = List<Data>.empty().obs;
  ProductApi _api = ProductApi();
  final String imgPath =
      "http://206.189.55.20:8080/preview/276ce05d-837b-4aa1-8f6f-ff02597a0e01/sf/x_file?_fai=";

  void fetchProducts(String customerId, String categoryId) async {
    productListCategory = allProducts
        .where((i) =>
            i.customerId == customerId && i.productCategoryId == categoryId)
        .toList();
  }

  void getCustomerProduct(id) {
    productListCustomer = allProducts.where((i) => i.customerId == id).toList();
  }

  Future fetchAllProducts() async {
    try {
      isLoading(true);
      var allProductPure = await _api.getAllProducts();
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
      fetchAllProducts();
      List<Data> filterProducts = List<Data>.of(
          allProducts.where((i) => i.productCategoryId == categoryId));
      return filterProducts;
    }
  }

  getProduct(String productId) {
    var product = allProducts.firstWhere((i) => i.frmProductId == productId);
    return product;
  }
}
