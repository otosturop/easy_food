import 'package:easy_food/data/products/orders_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class BasketController extends GetxController {
  var customerId = "".obs;
  var productAmount = "".obs;
  var productPrice = 0.0.obs;
  var productId = "".obs;
  var productName = "".obs;
  var myBasket = List<MyBasket>.empty().obs;
  var loop = false.obs;
  OrdersApi _api = OrdersApi();

  // Eğer customer değiştirise sepeti boşalt
  void assignCustomerId(String id) {
    if (customerId.isEmpty) {
      customerId.value = id;
    } else {
      if (customerId.value != id) {
        customerId.value = id;
        myBasket.clear();
      }
    }
  }

  getProductAmount(id, name, amount, price) {
    productAmount.value = amount;
    productId.value = id;
    productName.value = name;
    productPrice.value = price;
  }

  // Sepete ürün ekleme
  void addProductinMyBasket(
      List exmaterials, List removeMaterial, List menuItems) {
    myBasket.add(MyBasket(
        productId.value,
        productName.value,
        productPrice.value,
        int.parse(productAmount.value),
        exmaterials,
        removeMaterial,
        menuItems));
    update();
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

  Future<void> sendCartToServer(String totalPrice) async {
    try {
      var orderId = await _api.getOrderId("99999", "3", "1", totalPrice,
          customerId.value, "Merhaba bu mobil nottur");
      debugPrint("Sipariş numarası: " + orderId.outs.frmOrdersId.toString());
      myBasket.forEach((element) {
        _api.sendOrder(
            orderId.outs.frmOrdersId.toString(),
            element.productId,
            element.removedMaterial.map((e) => e.productMaterials).toString(),
            element.extraMaterial.map((i) => i.name).toString(),
            element.price.toStringAsFixed(2),
            element.amount.toString(),
            element.selectedMenu.map((x) => x.menuName).toString(),
            customerId.value);
      });
    } finally {}
  }
}

class MyBasket {
  String productId;
  String productName;
  double price;
  int amount;
  List extraMaterial;
  List removedMaterial;
  List selectedMenu;

  MyBasket(this.productId, this.productName, this.price, this.amount,
      this.extraMaterial, this.removedMaterial, this.selectedMenu);
}
