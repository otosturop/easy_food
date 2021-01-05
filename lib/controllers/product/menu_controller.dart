import 'package:easy_food/data/products/menu_api.dart';
import 'package:easy_food/model/MenuMaterialModel.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  var isLoading = true.obs;
  var menuList = List<Data>.empty().obs;
  var selectedMenu = [].obs;
  var tempMenuVal = Map<int, String>().obs;
  var productMenuItems = Map<int, Map<int, String>>().obs;
  MenuApi _api = MenuApi();

  @override
  void onInit() async {
    super.onInit();
  }

  Future fetchMenu(String productId) async {
    try {
      isLoading(true);
      var menuProducts = await _api.getMenus(productId);
      if (menuProducts != null) {
        menuList(menuProducts.data);
      }
    } finally {
      isLoading(false);
    }
  }

  addSelectedItemInMenu(menuProduct) {
    selectedMenu.add(menuProduct);
  }

  void assignTempVal(int index, String value) {
    if (index == 00 && value == "temp") {
      tempMenuVal.clear();
    } else {
      tempMenuVal[index] = value;
      addSelectedItemInMenu(value);
    }
  }
}
