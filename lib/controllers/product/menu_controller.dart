import 'package:easy_food/data/products/menu_api.dart';
import 'package:easy_food/model/MenuMaterialModel.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  var isLoading = true.obs;
  var menuList = List<Data>.empty().obs;
  var selectedMenu = List<MenuItems>.empty().obs;
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

  addSelectedItemInMenu(menuId, menuName) {
    selectedMenu.add(MenuItems(menuId, menuName));
  }

  void assignTempVal(int index, String value) {
    List valueSplit = value.split(",");
    if (index == 00 && value == "temp") {
      tempMenuVal.clear();
    } else {
      tempMenuVal[index] = value;
      addSelectedItemInMenu(valueSplit[0], valueSplit[1]);
    }
  }

  void clearSelectedMenu() {
    selectedMenu.clear();
  }
}

class MenuItems {
  final String menuId;
  final String menuName;

  MenuItems(this.menuId, this.menuName);
}
