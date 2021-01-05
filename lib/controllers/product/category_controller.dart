import 'package:easy_food/data/products/category_api.dart';
import 'package:easy_food/model/CategoriesModel.dart';
import 'package:get/state_manager.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = List<Data>.empty().obs;
  CategoryApi _api = CategoryApi();

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> fetchCategory(String userId) async {
    try {
      isLoading(true);
      var categories = await _api.getCategories(userId);
      if (categories != null) {
        categoryList(categories.data);
      }
    } finally {
      isLoading(false);
    }
  }
}
