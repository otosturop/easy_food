import 'package:easy_food/controllers/product/basket_controller.dart';
import 'package:easy_food/controllers/product/product_controller.dart';
import 'package:easy_food/screens/last_order.dart';
import 'package:easy_food/ui/foundation_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodBasket extends StatefulWidget {
  @override
  _FoodBasketState createState() => _FoodBasketState();
}

class _FoodBasketState extends State<FoodBasket> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final BasketController basketController = Get.put(BasketController());
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
  }

  String countTotalPrice() {
    double total = 0;
    basketController.myBasket.forEach((e) {
      total += e.amount * e.price;
      if (e.extraMaterial.length > 0) {
        e.extraMaterial.forEach((x) => total += x.price * e.amount);
      }
    });

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Obx(() {
        if (basketController.myBasket.length > 0)
          return ListView(
            children: [
              SizedBox(height: 15),
              // myBasket state saçma bir şekilde güncellenmediği için böyle bir gereksiz if koydum
              if (basketController.loop.value || !basketController.loop.value)
                for (var i in basketController.myBasket)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      elevation: 8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              leading: Icon(
                                Icons.food_bank_rounded,
                                size: 36.0,
                              ),
                              title: Text(i.productName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (i.extraMaterial.length > 0)
                                    Text(i.extraMaterial
                                        .map((e) => e.name)
                                        .toString()),
                                  if (i.selectedMenu.length > 0)
                                    Text(i.selectedMenu
                                        .map((e) => e.menuName)
                                        .toString()),
                                  if (i.removedMaterial.length > 0)
                                    Text(i.removedMaterial
                                        .map((e) => e.productMaterials)
                                        .toString())
                                ],
                              )),
                          Center(
                            child: Text((i.price * i.amount).toString() + "₺"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3.0,
                                            blurRadius: 5.0)
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              basketController.updateBasketItem(
                                                  i.productId, "increase");
                                            }),
                                        Text(i.amount.toString()),
                                        IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              basketController.updateBasketItem(
                                                  i.productId, "decrease");
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    basketController
                                        .removeBastetItem(i.productId);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              Card(
                elevation: 8,
                child: Column(
                  children: [
                    ListTile(
                      trailing: Icon(
                        Icons.food_bank_rounded,
                        size: 36.0,
                      ),
                      leading: Icon(
                        Icons.food_bank_rounded,
                        size: 36.0,
                      ),
                      title: Center(
                        child: Text(
                          "Total",
                          style: context.theme.textTheme.headline5,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Toplam Fİyat"),
                        Text(countTotalPrice() + "₺"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FoundationButton("Confirm cart", () {
                        basketController
                            .sendCartToServer(countTotalPrice())
                            .then((value) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LastOrder()));
                        });
                      }),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
            ],
          );
        else {
          return Center(
            child: Container(
              child: Text("Sepenizde Ürün Bulunmamaktadır. "),
            ),
          );
        }
      }),
    );
  }
}
