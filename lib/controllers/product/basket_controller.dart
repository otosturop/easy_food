import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class BasketController extends GetxController {
  var productAmount = "".obs;
  var productId = "".obs;
  var myBasket = List<MyBasket>.empty().obs;
  var loop = false.obs;

  getProductAmount(id, amount) {
    productAmount.value = amount;
    productId.value = id;
  }

  void addProductinMyBasket(
      List exmaterials, List removeMaterial, List menuItems) {
    myBasket.add(MyBasket(productId.value, int.parse(productAmount.value),
        exmaterials, removeMaterial, menuItems));
  }

  void updateBasketItem(id, progress) {
    loop(!loop.value);
    var temp = myBasket.firstWhere((item) => item.productId == id);
    int tempid = myBasket.indexOf(temp);
    if (progress == "increase") {
      myBasket[tempid].amount++;
    } else {
      if (myBasket[tempid].amount > 1) myBasket[tempid].amount--;
    }
  }

  void removeBastetItem(id) {
    var tempRemove = myBasket.firstWhere((item) => item.productId == id);
    myBasket.remove(tempRemove);
  }
}

class MyBasket {
  String productId;
  int amount;
  List extraMaterial;
  List removedMaterial;
  List selectedMenu;

  MyBasket(this.productId, this.amount, this.extraMaterial,
      this.removedMaterial, this.selectedMenu);
}
